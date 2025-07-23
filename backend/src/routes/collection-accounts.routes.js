import express from 'express';
import { query, validationResult } from 'express-validator';
import pool from '../config/database.js';
import { authenticate } from '../middleware/auth.js';

const router = express.Router();

// Validation middleware
const handleValidationErrors = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

// Get all delinquent accounts with filters
router.get('/accounts',
  authenticate,
  [
    query('bucket').optional().isIn(['all', 'Bucket 1', 'Bucket 2', 'Bucket 3', 'Bucket 4', 'Bucket 5']),
    query('product').optional().isIn(['all', 'Auto Finance', 'Personal Finance', 'Home Finance', 'SME Finance', 'Credit Card']),
    query('status').optional().isIn(['all', 'Active', 'Legal', 'Write-off Review', 'Closed']),
    query('branch').optional().isString(),
    query('search').optional().isString(),
    query('page').optional().isInt({ min: 1 }).toInt(),
    query('limit').optional().isInt({ min: 1, max: 100 }).toInt(),
  ],
  handleValidationErrors,
  async (req, res, next) => {
    try {
      const {
        bucket = 'all',
        product = 'all',
        status = 'all',
        branch = 'all',
        search = '',
        page = 1,
        limit = 50
      } = req.query;

      let whereConditions = ['fa.account_status = $1'];
      let params = ['Delinquent'];
      let paramCount = 1;

      // Add filters
      if (bucket !== 'all') {
        paramCount++;
        whereConditions.push(`fa.bucket = $${paramCount}`);
        params.push(bucket);
      }

      if (product !== 'all') {
        paramCount++;
        whereConditions.push(`fa.product_type = $${paramCount}`);
        params.push(product);
      }

      if (status !== 'all') {
        paramCount++;
        whereConditions.push(`cc.case_status = $${paramCount}`);
        params.push(status);
      }

      if (branch !== 'all') {
        paramCount++;
        whereConditions.push(`fa.branch_code = $${paramCount}`);
        params.push(branch);
      }

      if (search) {
        paramCount++;
        whereConditions.push(`(
          c.customer_name ILIKE $${paramCount} OR 
          c.national_id ILIKE $${paramCount} OR 
          fa.account_id ILIKE $${paramCount}
        )`);
        params.push(`%${search}%`);
      }

      const offset = (page - 1) * limit;

      // Get total count
      const countQuery = `
        SELECT COUNT(DISTINCT fa.account_id) as total
        FROM finance_accounts fa
        JOIN customers c ON fa.customer_id = c.customer_id
        LEFT JOIN collection_cases cc ON fa.account_id = cc.account_id
        LEFT JOIN customer_contacts cont ON c.customer_id = cont.customer_id AND cont.is_primary = true
        WHERE ${whereConditions.join(' AND ')}
      `;

      // Get accounts data
      const dataQuery = `
        SELECT 
          fa.account_id,
          fa.customer_id,
          CONCAT(c.first_name, ' ', c.last_name) as customer_name,
          c.national_id,
          fa.product_type,
          fa.outstanding_amount,
          fa.monthly_installment,
          fa.dpd,
          fa.bucket,
          cc.case_status,
          cc.priority_level as priority,
          cc.assigned_collector_id,
          col.employee_name as collector_name,
          cc.last_payment_date,
          cc.last_contact_date,
          cont.contact_value as phone_number,
          ce.contact_value as email,
          ca.contact_value as address
        FROM finance_accounts fa
        JOIN customers c ON fa.customer_id = c.customer_id
        LEFT JOIN collection_cases cc ON fa.account_id = cc.account_id
        LEFT JOIN collectors col ON cc.assigned_collector_id = col.collector_id
        LEFT JOIN customer_contacts cont ON c.customer_id = cont.customer_id AND cont.contact_type = 'Mobile' AND cont.is_primary = true
        LEFT JOIN customer_contacts ce ON c.customer_id = ce.customer_id AND ce.contact_type = 'Email' AND ce.is_primary = true
        LEFT JOIN customer_contacts ca ON c.customer_id = ca.customer_id AND ca.contact_type = 'Address' AND ca.is_primary = true
        WHERE ${whereConditions.join(' AND ')}
        ORDER BY fa.dpd DESC, fa.outstanding_amount DESC
        LIMIT $${paramCount + 1} OFFSET $${paramCount + 2}
      `;

      params.push(limit, offset);

      const [countResult, dataResult] = await Promise.all([
        pool.query(countQuery, params.slice(0, -2)),
        pool.query(dataQuery, params)
      ]);

      res.json({
        accounts: dataResult.rows,
        pagination: {
          total: parseInt(countResult.rows[0].total),
          page,
          limit,
          totalPages: Math.ceil(countResult.rows[0].total / limit)
        }
      });
    } catch (error) {
      next(error);
    }
  }
);

// Get account details
router.get('/accounts/:accountId',
  authenticate,
  async (req, res, next) => {
    try {
      const { accountId } = req.params;

      const query = `
        SELECT 
          fa.*,
          c.first_name,
          c.last_name,
          CONCAT(c.first_name, ' ', c.last_name) as customer_name,
          c.national_id,
          c.date_of_birth,
          c.gender,
          c.nationality,
          c.employment_status,
          c.employer_name,
          c.monthly_income,
          c.credit_score,
          c.risk_category,
          cc.case_id,
          cc.case_status,
          cc.priority_level,
          cc.assigned_collector_id,
          col.employee_name as collector_name,
          cc.last_payment_date,
          cc.last_contact_date,
          cc.next_action_date
        FROM finance_accounts fa
        JOIN customers c ON fa.customer_id = c.customer_id
        LEFT JOIN collection_cases cc ON fa.account_id = cc.account_id
        LEFT JOIN collectors col ON cc.assigned_collector_id = col.collector_id
        WHERE fa.account_id = $1
      `;

      const contactsQuery = `
        SELECT contact_type, contact_value, is_primary, is_valid
        FROM customer_contacts
        WHERE customer_id = (SELECT customer_id FROM finance_accounts WHERE account_id = $1)
        ORDER BY is_primary DESC, contact_type
      `;

      const activitiesQuery = `
        SELECT 
          ca.activity_id,
          ca.activity_type,
          ca.activity_datetime,
          ca.activity_result,
          ca.notes,
          ca.collector_id,
          col.employee_name as collector_name
        FROM collection_activities ca
        LEFT JOIN collectors col ON ca.collector_id = col.collector_id
        WHERE ca.account_id = $1
        ORDER BY ca.activity_datetime DESC
        LIMIT 10
      `;

      const paymentsQuery = `
        SELECT 
          payment_date,
          payment_amount,
          payment_method,
          payment_channel,
          receipt_number
        FROM payment_transactions
        WHERE account_id = $1
        ORDER BY payment_date DESC
        LIMIT 10
      `;

      const [accountResult, contactsResult, activitiesResult, paymentsResult] = await Promise.all([
        pool.query(query, [accountId]),
        pool.query(contactsQuery, [accountId]),
        pool.query(activitiesQuery, [accountId]),
        pool.query(paymentsQuery, [accountId])
      ]);

      if (accountResult.rows.length === 0) {
        return res.status(404).json({ error: 'Account not found' });
      }

      res.json({
        account: accountResult.rows[0],
        contacts: contactsResult.rows,
        recentActivities: activitiesResult.rows,
        recentPayments: paymentsResult.rows
      });
    } catch (error) {
      next(error);
    }
  }
);

// Update account assignment
router.put('/accounts/:accountId/assign',
  authenticate,
  async (req, res, next) => {
    try {
      const { accountId } = req.params;
      const { collectorId } = req.body;

      const query = `
        UPDATE collection_cases
        SET 
          assigned_collector_id = $1,
          assignment_date = CURRENT_DATE,
          updated_date = CURRENT_TIMESTAMP
        WHERE account_id = $2
        RETURNING case_id
      `;

      const result = await pool.query(query, [collectorId, accountId]);

      if (result.rows.length === 0) {
        return res.status(404).json({ error: 'Collection case not found' });
      }

      res.json({ 
        success: true, 
        caseId: result.rows[0].case_id,
        message: 'Account successfully reassigned' 
      });
    } catch (error) {
      next(error);
    }
  }
);

export default router;