import express from 'express';
import { body, query, validationResult } from 'express-validator';
import pool from '../config/database.js';
import { authenticate, authorize } from '../middleware/auth.js';

const router = express.Router();

// Validation middleware
const handleValidationErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

// Get all collection transactions with filters
router.get('/',
  authenticate,
  [
    query('branchId').optional().isInt(),
    query('startDate').optional().isISO8601(),
    query('endDate').optional().isISO8601(),
    query('status').optional().isIn(['pending', 'completed', 'cancelled']),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 })
  ],
  handleValidationErrors,
  async (req, res, next) => {
    try {
      const { 
        branchId, 
        startDate, 
        endDate, 
        status,
        page = 1,
        limit = 20
      } = req.query;
      
      let whereConditions = [];
      let params = [];
      let paramCount = 1;
      
      if (branchId) {
        whereConditions.push(`ct.branch_id = $${paramCount}`);
        params.push(branchId);
        paramCount++;
      }
      
      if (startDate && endDate) {
        whereConditions.push(`ct.transaction_date BETWEEN $${paramCount} AND $${paramCount + 1}`);
        params.push(startDate, endDate);
        paramCount += 2;
      }
      
      if (status) {
        whereConditions.push(`ct.status = $${paramCount}`);
        params.push(status);
        paramCount++;
      }
      
      const whereClause = whereConditions.length > 0 
        ? 'WHERE ' + whereConditions.join(' AND ')
        : '';
      
      // Get total count
      const countResult = await pool.query(
        `SELECT COUNT(*) FROM collection_transactions ct ${whereClause}`,
        params
      );
      
      const totalCount = parseInt(countResult.rows[0].count);
      const totalPages = Math.ceil(totalCount / limit);
      const offset = (page - 1) * limit;
      
      // Get paginated results
      params.push(limit, offset);
      
      const result = await pool.query(
        `SELECT ct.*, 
                b.branch_name, 
                b.branch_code,
                u.first_name || ' ' || u.last_name as collector_name
         FROM collection_transactions ct
         JOIN branches b ON ct.branch_id = b.id
         LEFT JOIN users u ON ct.collector_id = u.id
         ${whereClause}
         ORDER BY ct.transaction_date DESC, ct.created_at DESC
         LIMIT $${paramCount} OFFSET $${paramCount + 1}`,
        params
      );
      
      res.json({
        data: result.rows,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          totalCount,
          totalPages
        }
      });
    } catch (error) {
      next(error);
    }
  }
);

// Get collection transaction by ID
router.get('/:id', authenticate, async (req, res, next) => {
  try {
    const { id } = req.params;
    
    const result = await pool.query(
      `SELECT ct.*, 
              b.branch_name, 
              b.branch_code,
              u.first_name || ' ' || u.last_name as collector_name
       FROM collection_transactions ct
       JOIN branches b ON ct.branch_id = b.id
       LEFT JOIN users u ON ct.collector_id = u.id
       WHERE ct.id = $1`,
      [id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Transaction not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    next(error);
  }
});

// Create new collection transaction
router.post('/',
  authenticate,
  authorize('admin', 'manager', 'collector'),
  [
    body('branchId').isInt(),
    body('transactionDate').isISO8601(),
    body('customerId').optional().trim(),
    body('customerName').notEmpty().trim(),
    body('accountNumber').optional().trim(),
    body('transactionType').notEmpty().trim(),
    body('amount').isFloat({ min: 0 }),
    body('currency').optional().default('SAR'),
    body('paymentMethod').optional().trim(),
    body('status').optional().isIn(['pending', 'completed', 'cancelled']),
    body('referenceNumber').optional().trim(),
    body('notes').optional().trim()
  ],
  handleValidationErrors,
  async (req, res, next) => {
    try {
      const {
        branchId,
        transactionDate,
        customerId,
        customerName,
        accountNumber,
        transactionType,
        amount,
        currency,
        paymentMethod,
        status = 'completed',
        referenceNumber,
        notes
      } = req.body;
      
      // Check if reference number is unique
      if (referenceNumber) {
        const existing = await pool.query(
          'SELECT id FROM collection_transactions WHERE reference_number = $1',
          [referenceNumber]
        );
        
        if (existing.rows.length > 0) {
          return res.status(409).json({ error: 'Reference number already exists' });
        }
      }
      
      const result = await pool.query(
        `INSERT INTO collection_transactions 
         (branch_id, transaction_date, customer_id, customer_name, account_number,
          transaction_type, amount, currency, payment_method, collector_id, 
          status, reference_number, notes)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
         RETURNING *`,
        [
          branchId, transactionDate, customerId, customerName, accountNumber,
          transactionType, amount, currency, paymentMethod, req.user.id,
          status, referenceNumber, notes
        ]
      );
      
      res.status(201).json(result.rows[0]);
    } catch (error) {
      next(error);
    }
  }
);

// Update collection transaction
router.put('/:id',
  authenticate,
  authorize('admin', 'manager'),
  [
    body('status').optional().isIn(['pending', 'completed', 'cancelled']),
    body('notes').optional().trim()
  ],
  handleValidationErrors,
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const { status, notes } = req.body;
      
      const updateFields = [];
      const values = [];
      let paramCount = 1;
      
      if (status) {
        updateFields.push(`status = $${paramCount}`);
        values.push(status);
        paramCount++;
      }
      
      if (notes !== undefined) {
        updateFields.push(`notes = $${paramCount}`);
        values.push(notes);
        paramCount++;
      }
      
      if (updateFields.length === 0) {
        return res.status(400).json({ error: 'No fields to update' });
      }
      
      values.push(id);
      
      const result = await pool.query(
        `UPDATE collection_transactions 
         SET ${updateFields.join(', ')}
         WHERE id = $${paramCount}
         RETURNING *`,
        values
      );
      
      if (result.rows.length === 0) {
        return res.status(404).json({ error: 'Transaction not found' });
      }
      
      res.json(result.rows[0]);
    } catch (error) {
      next(error);
    }
  }
);

// Delete collection transaction
router.delete('/:id',
  authenticate,
  authorize('admin'),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      
      const result = await pool.query(
        'DELETE FROM collection_transactions WHERE id = $1 RETURNING id',
        [id]
      );
      
      if (result.rows.length === 0) {
        return res.status(404).json({ error: 'Transaction not found' });
      }
      
      res.json({ message: 'Transaction deleted successfully' });
    } catch (error) {
      next(error);
    }
  }
);

// Get collection targets
router.get('/targets/:branchId',
  authenticate,
  async (req, res, next) => {
    try {
      const { branchId } = req.params;
      const { year } = req.query;
      
      let query = `
        SELECT ct.*, 
               b.branch_name,
               u.first_name || ' ' || u.last_name as created_by_name
        FROM collection_targets ct
        JOIN branches b ON ct.branch_id = b.id
        LEFT JOIN users u ON ct.created_by = u.id
        WHERE ct.branch_id = $1
      `;
      
      const params = [branchId];
      
      if (year) {
        query += ' AND ct.target_year = $2';
        params.push(year);
      }
      
      query += ' ORDER BY ct.target_year DESC, ct.target_month DESC';
      
      const result = await pool.query(query, params);
      res.json(result.rows);
    } catch (error) {
      next(error);
    }
  }
);

// Set collection target
router.post('/targets',
  authenticate,
  authorize('admin', 'manager'),
  [
    body('branchId').isInt(),
    body('targetMonth').isInt({ min: 1, max: 12 }),
    body('targetYear').isInt({ min: 2020 }),
    body('targetAmount').isFloat({ min: 0 }),
    body('currency').optional().default('SAR')
  ],
  handleValidationErrors,
  async (req, res, next) => {
    try {
      const { branchId, targetMonth, targetYear, targetAmount, currency } = req.body;
      
      const result = await pool.query(
        `INSERT INTO collection_targets 
         (branch_id, target_month, target_year, target_amount, currency, created_by)
         VALUES ($1, $2, $3, $4, $5, $6)
         ON CONFLICT (branch_id, target_month, target_year)
         DO UPDATE SET target_amount = $4, currency = $5, created_by = $6
         RETURNING *`,
        [branchId, targetMonth, targetYear, targetAmount, currency, req.user.id]
      );
      
      res.json(result.rows[0]);
    } catch (error) {
      next(error);
    }
  }
);

export default router;