import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:5000/api/v1';

// Create axios instance with default config
const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add auth token to requests
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Collection Dashboard Services
export const collectionDashboardService = {
  // Get dashboard summary metrics
  getSummaryMetrics: async (filters = {}) => {
    const response = await api.get('/collection/dashboard/summary', { params: filters });
    return response.data;
  },

  // Get collection trends
  getCollectionTrends: async (period, filters = {}) => {
    const response = await api.get(`/collection/dashboard/trends/${period}`, { params: filters });
    return response.data;
  },

  // Get aging analysis
  getAgingAnalysis: async (filters = {}) => {
    const response = await api.get('/collection/dashboard/aging', { params: filters });
    return response.data;
  },

  // Get collector performance
  getCollectorPerformance: async (filters = {}) => {
    const response = await api.get('/collection/dashboard/collector-performance', { params: filters });
    return response.data;
  },

  // Get product-wise NPF
  getProductNPF: async (filters = {}) => {
    const response = await api.get('/collection/dashboard/product-npf', { params: filters });
    return response.data;
  }
};

// Collection Reports Services
export const collectionReportsService = {
  // Get daily collection report
  getDailyCollection: async (date, filters = {}) => {
    const response = await api.get('/collection/reports/daily', { 
      params: { date, ...filters } 
    });
    return response.data;
  },

  // Get collector productivity report
  getCollectorProductivity: async (dateRange, filters = {}) => {
    const response = await api.get('/collection/reports/productivity', { 
      params: { ...dateRange, ...filters } 
    });
    return response.data;
  },

  // Get aging movement report
  getAgingMovement: async (period, filters = {}) => {
    const response = await api.get('/collection/reports/aging-movement', { 
      params: { period, ...filters } 
    });
    return response.data;
  },

  // Get PTP analysis report
  getPTPAnalysis: async (dateRange, filters = {}) => {
    const response = await api.get('/collection/reports/ptp-analysis', { 
      params: { ...dateRange, ...filters } 
    });
    return response.data;
  },

  // Get legal cases report
  getLegalCases: async (filters = {}) => {
    const response = await api.get('/collection/reports/legal-cases', { params: filters });
    return response.data;
  },

  // Get settlement report
  getSettlementReport: async (dateRange, filters = {}) => {
    const response = await api.get('/collection/reports/settlements', { 
      params: { ...dateRange, ...filters } 
    });
    return response.data;
  },

  // Export report
  exportReport: async (reportType, format, filters = {}) => {
    const response = await api.get(`/collection/reports/export/${reportType}`, {
      params: { format, ...filters },
      responseType: 'blob'
    });
    return response.data;
  }
};

// Collection Analytics Services
export const collectionAnalyticsService = {
  // Get performance trends
  getPerformanceTrends: async (period, metrics, filters = {}) => {
    const response = await api.get('/collection/analytics/trends', { 
      params: { period, metrics, ...filters } 
    });
    return response.data;
  },

  // Get risk segmentation
  getRiskSegmentation: async (filters = {}) => {
    const response = await api.get('/collection/analytics/risk-segmentation', { params: filters });
    return response.data;
  },

  // Get behavioral analysis
  getBehavioralAnalysis: async (filters = {}) => {
    const response = await api.get('/collection/analytics/behavioral', { params: filters });
    return response.data;
  },

  // Get predictive insights
  getPredictiveInsights: async (filters = {}) => {
    const response = await api.get('/collection/analytics/predictive', { params: filters });
    return response.data;
  },

  // Get recovery probability
  getRecoveryProbability: async (filters = {}) => {
    const response = await api.get('/collection/analytics/recovery-probability', { params: filters });
    return response.data;
  }
};

// Collection Accounts Services
export const collectionAccountsService = {
  // Get accounts list
  getAccounts: async (page = 1, limit = 20, filters = {}) => {
    const response = await api.get('/collection/accounts', { 
      params: { page, limit, ...filters } 
    });
    return response.data;
  },

  // Get account details
  getAccountDetails: async (accountId) => {
    const response = await api.get(`/collection/accounts/${accountId}`);
    return response.data;
  },

  // Update account status
  updateAccountStatus: async (accountId, status) => {
    const response = await api.patch(`/collection/accounts/${accountId}/status`, { status });
    return response.data;
  },

  // Assign collector
  assignCollector: async (accountId, collectorId) => {
    const response = await api.post(`/collection/accounts/${accountId}/assign`, { collectorId });
    return response.data;
  }
};

// Collection Activities Services
export const collectionActivitiesService = {
  // Get activities list
  getActivities: async (filters = {}) => {
    const response = await api.get('/collection/activities', { params: filters });
    return response.data;
  },

  // Create new activity
  createActivity: async (activityData) => {
    const response = await api.post('/collection/activities', activityData);
    return response.data;
  },

  // Update activity
  updateActivity: async (activityId, activityData) => {
    const response = await api.put(`/collection/activities/${activityId}`, activityData);
    return response.data;
  },

  // Get activity types
  getActivityTypes: async () => {
    const response = await api.get('/collection/activities/types');
    return response.data;
  }
};

// Promise to Pay Services
export const ptpService = {
  // Get PTP list
  getPTPs: async (filters = {}) => {
    const response = await api.get('/collection/ptp', { params: filters });
    return response.data;
  },

  // Create PTP
  createPTP: async (ptpData) => {
    const response = await api.post('/collection/ptp', ptpData);
    return response.data;
  },

  // Update PTP status
  updatePTPStatus: async (ptpId, status, paymentData = {}) => {
    const response = await api.patch(`/collection/ptp/${ptpId}/status`, { 
      status, 
      ...paymentData 
    });
    return response.data;
  }
};

// Legal Cases Services
export const legalCasesService = {
  // Get legal cases
  getLegalCases: async (filters = {}) => {
    const response = await api.get('/collection/legal-cases', { params: filters });
    return response.data;
  },

  // Get case details
  getCaseDetails: async (caseId) => {
    const response = await api.get(`/collection/legal-cases/${caseId}`);
    return response.data;
  },

  // Create legal case
  createLegalCase: async (caseData) => {
    const response = await api.post('/collection/legal-cases', caseData);
    return response.data;
  },

  // Update case status
  updateCaseStatus: async (caseId, status, updateData = {}) => {
    const response = await api.patch(`/collection/legal-cases/${caseId}/status`, { 
      status, 
      ...updateData 
    });
    return response.data;
  }
};

// Settlement Services
export const settlementService = {
  // Get settlements
  getSettlements: async (filters = {}) => {
    const response = await api.get('/collection/settlements', { params: filters });
    return response.data;
  },

  // Create settlement proposal
  createSettlement: async (settlementData) => {
    const response = await api.post('/collection/settlements', settlementData);
    return response.data;
  },

  // Approve/Reject settlement
  updateSettlementStatus: async (settlementId, status, remarks = '') => {
    const response = await api.patch(`/collection/settlements/${settlementId}/status`, { 
      status, 
      remarks 
    });
    return response.data;
  }
};

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