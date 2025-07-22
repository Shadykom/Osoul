import { supabase, handleSupabaseError } from '@/lib/supabase';

// Collection Dashboard Service
export const collectionDashboardService = {
  // Get summary metrics
  getSummaryMetrics: async (filters = {}) => {
    try {
      // Get total outstanding and collection metrics
      const { data: accounts, error: accountsError } = await supabase
        .from('finance_accounts')
        .select('outstanding_amount, dpd, account_status')
        .eq('account_status', 'Delinquent');

      if (accountsError) throw accountsError;

      // Get recent collections
      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
      
      const { data: collections, error: collectionsError } = await supabase
        .from('payment_transactions')
        .select('payment_amount')
        .gte('payment_date', thirtyDaysAgo.toISOString());

      if (collectionsError) throw collectionsError;

      // Get active PTPs
      const { data: ptps, error: ptpsError } = await supabase
        .from('promise_to_pay')
        .select('*')
        .eq('ptp_status', 'Active');

      if (ptpsError) throw ptpsError;

      // Calculate metrics
      const totalOutstanding = accounts.reduce((sum, acc) => sum + parseFloat(acc.outstanding_amount || 0), 0);
      const totalCollected = collections.reduce((sum, col) => sum + parseFloat(col.payment_amount || 0), 0);
      const activeAccounts = accounts.length;
      const promisesToPay = ptps.length;
      const avgDPD = accounts.length > 0 ? accounts.reduce((sum, acc) => sum + acc.dpd, 0) / accounts.length : 0;
      const nplAccounts = accounts.filter(acc => acc.dpd > 90).length;
      const nplRatio = activeAccounts > 0 ? (nplAccounts / activeAccounts) * 100 : 0;

      return {
        data: {
          totalOutstanding,
          totalCollected,
          collectionRate: totalOutstanding > 0 ? (totalCollected / totalOutstanding) * 100 : 0,
          activeAccounts,
          promisesToPay,
          ptpKeptRate: 73.3, // This would need historical PTP data
          avgDPD: Math.round(avgDPD),
          nplRatio: Math.round(nplRatio * 10) / 10
        }
      };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get collection trends
  getCollectionTrends: async (period = 'daily', filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('v_daily_collection_summary')
        .select('*')
        .order('collection_date', { ascending: true });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get aging analysis
  getAgingAnalysis: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('v_portfolio_aging')
        .select('*');

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get collector performance
  getCollectorPerformance: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('v_collector_performance_summary')
        .select('*');

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get product NPF
  getProductNPF: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('v_npf_by_product')
        .select('*');

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Collection Reports Service
export const collectionReportsService = {
  // Get daily collection report
  getDailyCollection: async (date, filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('payment_transactions')
        .select(`
          *,
          customers!inner(first_name, last_name),
          finance_accounts!inner(account_id, product_type)
        `)
        .eq('payment_date', date)
        .order('payment_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get collector productivity
  getCollectorProductivity: async (startDate, endDate, filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('collector_performance')
        .select(`
          *,
          collectors!inner(employee_name, team_name)
        `)
        .gte('performance_date', startDate)
        .lte('performance_date', endDate)
        .order('performance_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get aging movement
  getAgingMovement: async (month, filters = {}) => {
    try {
      // This would need a more complex query or stored procedure
      const { data, error } = await supabase
        .from('finance_accounts')
        .select('account_id, bucket, outstanding_amount, dpd')
        .order('dpd', { ascending: true });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get PTP analysis
  getPTPAnalysis: async (startDate, endDate, filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('promise_to_pay')
        .select(`
          *,
          collectors!inner(employee_name),
          customers!inner(first_name, last_name)
        `)
        .gte('promise_date', startDate)
        .lte('promise_date', endDate)
        .order('promise_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get legal cases report
  getLegalCases: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('legal_cases')
        .select(`
          *,
          customers!inner(first_name, last_name, national_id),
          finance_accounts!inner(account_id, outstanding_amount)
        `)
        .order('filing_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get settlements report
  getSettlements: async (startDate, endDate, filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('settlements')
        .select(`
          *,
          customers!inner(first_name, last_name),
          finance_accounts!inner(account_id, product_type)
        `)
        .gte('created_date', startDate)
        .lte('created_date', endDate)
        .order('created_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Collection Analytics Service
export const collectionAnalyticsService = {
  // Get performance trends
  getPerformanceTrends: async (period, metric, filters = {}) => {
    try {
      // This would aggregate data based on period and metric
      const { data, error } = await supabase
        .from('collector_performance')
        .select('*')
        .order('performance_date', { ascending: true });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get risk segmentation
  getRiskSegmentation: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('customers')
        .select(`
          risk_category,
          finance_accounts!inner(outstanding_amount, dpd)
        `);

      if (error) throw error;

      // Process data for risk segmentation
      const segmentation = data.reduce((acc, customer) => {
        const category = customer.risk_category || 'Unknown';
        if (!acc[category]) {
          acc[category] = { count: 0, totalOutstanding: 0 };
        }
        acc[category].count++;
        customer.finance_accounts.forEach(account => {
          acc[category].totalOutstanding += parseFloat(account.outstanding_amount || 0);
        });
        return acc;
      }, {});

      return { data: segmentation };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get behavioral analysis
  getBehavioralAnalysis: async (filters = {}) => {
    try {
      const { data, error } = await supabase
        .from('collection_activities')
        .select(`
          activity_type,
          activity_result,
          promise_amount
        `)
        .order('activity_datetime', { ascending: false })
        .limit(1000);

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get predictive insights
  getPredictiveInsights: async (filters = {}) => {
    try {
      // This would use historical data to predict future performance
      const { data: ptpData, error: ptpError } = await supabase
        .from('v_ptp_success_rate')
        .select('*')
        .order('ptp_date', { ascending: false })
        .limit(30);

      if (ptpError) throw ptpError;

      return { data: { ptpTrends: ptpData } };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Collection Accounts Service
export const collectionAccountsService = {
  // Get collection accounts list
  getAccounts: async (filters = {}) => {
    try {
      let query = supabase
        .from('collection_cases')
        .select(`
          *,
          finance_accounts!inner(*),
          customers!inner(*),
          collectors!inner(employee_name)
        `);

      // Apply filters
      if (filters.status) {
        query = query.eq('case_status', filters.status);
      }
      if (filters.priority) {
        query = query.eq('priority_level', filters.priority);
      }
      if (filters.collector) {
        query = query.eq('assigned_collector_id', filters.collector);
      }

      const { data, error } = await query.order('total_outstanding', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get account details
  getAccountDetails: async (accountId) => {
    try {
      const { data, error } = await supabase
        .from('finance_accounts')
        .select(`
          *,
          customers!inner(*),
          collection_cases!inner(*),
          payment_schedule(*),
          payment_transactions(*)
        `)
        .eq('account_id', accountId)
        .single();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Update account status
  updateAccountStatus: async (accountId, status) => {
    try {
      const { data, error } = await supabase
        .from('finance_accounts')
        .update({ account_status: status })
        .eq('account_id', accountId);

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Assign collector
  assignCollector: async (caseId, collectorId) => {
    try {
      const { data, error } = await supabase
        .from('collection_cases')
        .update({ 
          assigned_collector_id: collectorId,
          assignment_date: new Date().toISOString()
        })
        .eq('case_id', caseId);

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Collection Activities Service
export const collectionActivitiesService = {
  // Get activities
  getActivities: async (filters = {}) => {
    try {
      let query = supabase
        .from('collection_activities')
        .select(`
          *,
          collectors!inner(employee_name),
          collection_cases!inner(*)
        `);

      // Apply filters
      if (filters.accountId) {
        query = query.eq('account_id', filters.accountId);
      }
      if (filters.collectorId) {
        query = query.eq('collector_id', filters.collectorId);
      }
      if (filters.activityType) {
        query = query.eq('activity_type', filters.activityType);
      }

      const { data, error } = await query
        .order('activity_datetime', { ascending: false })
        .limit(100);

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Create activity
  createActivity: async (activityData) => {
    try {
      const { data, error } = await supabase
        .from('collection_activities')
        .insert({
          ...activityData,
          activity_datetime: new Date().toISOString()
        })
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get activity types
  getActivityTypes: async () => {
    return {
      data: [
        { value: 'Call', label: 'Phone Call' },
        { value: 'SMS', label: 'SMS' },
        { value: 'Email', label: 'Email' },
        { value: 'Visit', label: 'Field Visit' },
        { value: 'Letter', label: 'Letter' },
        { value: 'Legal Notice', label: 'Legal Notice' }
      ]
    };
  }
};

// PTP Service
export const ptpService = {
  // Create PTP
  createPTP: async (ptpData) => {
    try {
      const { data, error } = await supabase
        .from('promise_to_pay')
        .insert(ptpData)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Update PTP
  updatePTP: async (ptpId, updates) => {
    try {
      const { data, error } = await supabase
        .from('promise_to_pay')
        .update(updates)
        .eq('ptp_id', ptpId)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Get PTPs
  getPTPs: async (filters = {}) => {
    try {
      let query = supabase
        .from('promise_to_pay')
        .select(`
          *,
          customers!inner(first_name, last_name),
          collectors!inner(employee_name)
        `);

      if (filters.status) {
        query = query.eq('ptp_status', filters.status);
      }
      if (filters.accountId) {
        query = query.eq('account_id', filters.accountId);
      }

      const { data, error } = await query.order('promise_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Legal Cases Service
export const legalCasesService = {
  // Get legal cases
  getCases: async (filters = {}) => {
    try {
      let query = supabase
        .from('legal_cases')
        .select(`
          *,
          customers!inner(first_name, last_name, national_id),
          finance_accounts!inner(account_id, outstanding_amount)
        `);

      if (filters.status) {
        query = query.eq('case_status', filters.status);
      }

      const { data, error } = await query.order('filing_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Create legal case
  createCase: async (caseData) => {
    try {
      const { data, error } = await supabase
        .from('legal_cases')
        .insert(caseData)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Update legal case
  updateCase: async (caseId, updates) => {
    try {
      const { data, error } = await supabase
        .from('legal_cases')
        .update(updates)
        .eq('legal_case_id', caseId)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Settlement Service
export const settlementService = {
  // Get settlements
  getSettlements: async (filters = {}) => {
    try {
      let query = supabase
        .from('settlements')
        .select(`
          *,
          customers!inner(first_name, last_name),
          finance_accounts!inner(account_id, product_type)
        `);

      if (filters.status) {
        query = query.eq('settlement_status', filters.status);
      }

      const { data, error } = await query.order('created_date', { ascending: false });

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Create settlement
  createSettlement: async (settlementData) => {
    try {
      const { data, error } = await supabase
        .from('settlements')
        .insert(settlementData)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  },

  // Approve settlement
  approveSettlement: async (settlementId, approvalData) => {
    try {
      const { data, error } = await supabase
        .from('settlements')
        .update({
          settlement_status: 'Approved',
          approved_by: approvalData.approvedBy,
          approval_date: new Date().toISOString()
        })
        .eq('settlement_id', settlementId)
        .select();

      if (error) throw error;

      return { data };
    } catch (error) {
      return { error: handleSupabaseError(error) };
    }
  }
};

// Export all services
export default {
  dashboard: collectionDashboardService,
  reports: collectionReportsService,
  analytics: collectionAnalyticsService,
  accounts: collectionAccountsService,
  activities: collectionActivitiesService,
  ptp: ptpService,
  legal: legalCasesService,
  settlement: settlementService
};