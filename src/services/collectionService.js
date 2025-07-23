// src/services/collectionService.js
import api from './api';

// Collection Accounts Service
export const collectionAccountsService = {
  getAccounts: async (page = 1, limit = 20, filters = {}) => {
    try {
      const params = new URLSearchParams({
        page,
        limit,
        ...filters
      });
      const response = await api.get(`/collection/accounts?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching accounts:', error);
      throw error;
    }
  }
};

// Collection Activities Service
export const collectionActivitiesService = {
  getActivities: async (filters = {}) => {
    try {
      const params = new URLSearchParams(filters);
      const response = await api.get(`/collection/activities?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching activities:', error);
      throw error;
    }
  }
};

// Legal Cases Service
export const legalCasesService = {
  getLegalCases: async (filters = {}) => {
    try {
      const params = new URLSearchParams(filters);
      const response = await api.get(`/collection/legal-cases?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching legal cases:', error);
      throw error;
    }
  }
};

// Collection Reports Service - THIS IS THE MISSING EXPORT!
export const collectionReportsService = {
  getDailyCollection: async (date, filters = {}) => {
    try {
      const params = new URLSearchParams({
        date,
        ...filters
      });
      const response = await api.get(`/collection/reports/daily?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching daily collection:', error);
      throw error;
    }
  },

  getCollectorProductivity: async (dateRange, filters = {}) => {
    try {
      const params = new URLSearchParams({
        ...dateRange,
        ...filters
      });
      const response = await api.get(`/collection/reports/productivity?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching collector productivity:', error);
      throw error;
    }
  },

  getAgingMovement: async (period, filters = {}) => {
    try {
      const params = new URLSearchParams({
        period,
        ...filters
      });
      const response = await api.get(`/collection/reports/aging?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching aging movement:', error);
      throw error;
    }
  },

  getPTPAnalysis: async (dateRange, filters = {}) => {
    try {
      const params = new URLSearchParams({
        ...dateRange,
        ...filters
      });
      const response = await api.get(`/collection/reports/ptp?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching PTP analysis:', error);
      throw error;
    }
  },

  getLegalCases: async (filters = {}) => {
    try {
      const params = new URLSearchParams(filters);
      const response = await api.get(`/collection/reports/legal?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching legal cases report:', error);
      throw error;
    }
  },

  getSettlementReport: async (dateRange, filters = {}) => {
    try {
      const params = new URLSearchParams({
        ...dateRange,
        ...filters
      });
      const response = await api.get(`/collection/reports/settlement?${params}`);
      return response.data;
    } catch (error) {
      console.error('Error fetching settlement report:', error);
      throw error;
    }
  }
};

// Default export for backward compatibility
const collectionService = {
  accounts: collectionAccountsService,
  activities: collectionActivitiesService,
  legal: legalCasesService,
  reports: collectionReportsService
};

export default collectionService;