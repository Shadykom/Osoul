import { apiMethods } from './api.js';
import { collectionReportsService } from './supabaseCollectionService.js';

class CollectionService {
  constructor() {
    console.log('📋 Collection Service initialized');
  }

  // Get collection accounts with pagination and filtering
  async getAccounts(params = {}) {
    try {
      console.log('📋 Fetching collection accounts with params:', params);
      
      // Default parameters
      const defaultParams = {
        page: 1,
        limit: 20,
        sortBy: 'created_date',
        sortOrder: 'desc'
      };
      
      const queryParams = { ...defaultParams, ...params };
      console.log('📋 Final query params:', queryParams);
      
      const response = await apiMethods.getCollectionAccounts(queryParams);
      
      if (response.success && response.data) {
        console.log('✅ Collection accounts fetched successfully:', {
          total: response.data.pagination?.totalRecords,
          returned: response.data.accounts?.length,
          page: response.data.pagination?.currentPage
        });
        
        return {
          success: true,
          accounts: response.data.accounts || [],
          pagination: response.data.pagination || {},
          summary: response.data.summary || {},
          message: response.message
        };
      } else {
        throw new Error(response.message || 'Failed to fetch collection accounts');
      }
    } catch (error) {
      console.error('❌ Error fetching collection accounts:', error);
      
      // Provide user-friendly error messages
      let errorMessage = 'Failed to load collection accounts';
      
      if (error.response?.status === 401) {
        errorMessage = 'Authentication required. Please log in again.';
      } else if (error.response?.status === 403) {
        errorMessage = 'Access denied. You do not have permission to view collection accounts.';
      } else if (error.response?.status === 500) {
        errorMessage = 'Server error. Please try again later.';
      } else if (error.response?.data?.error) {
        errorMessage = error.response.data.error;
      } else if (error.message.includes('Network Error')) {
        errorMessage = 'Network error. Please check your connection.';
      }
      
      throw new Error(errorMessage);
    }
  }

  // Get specific collection account details
  async getAccount(accountId) {
    try {
      console.log('🔍 Fetching collection account details for ID:', accountId);
      
      if (!accountId) {
        throw new Error('Account ID is required');
      }
      
      const response = await apiMethods.getCollectionAccount(accountId);
      
      if (response.success && response.data) {
        console.log('✅ Collection account details fetched successfully');
        
        return {
          success: true,
          account: response.data,
          message: response.message
        };
      } else {
        throw new Error(response.message || 'Failed to fetch account details');
      }
    } catch (error) {
      console.error('❌ Error fetching collection account details:', error);
      
      let errorMessage = 'Failed to load account details';
      
      if (error.response?.status === 401) {
        errorMessage = 'Authentication required. Please log in again.';
      } else if (error.response?.status === 403) {
        errorMessage = 'Access denied. You do not have permission to view this account.';
      } else if (error.response?.status === 404) {
        errorMessage = 'Account not found.';
      } else if (error.response?.status === 500) {
        errorMessage = 'Server error. Please try again later.';
      } else if (error.response?.data?.error) {
        errorMessage = error.response.data.error;
      }
      
      throw new Error(errorMessage);
    }
  }

  // Get daily collection report
  async getDailyReport(params = {}) {
    try {
      console.log('📊 Fetching daily collection report with params:', params);
      
      // Default to today's date if not specified
      const defaultParams = {
        date: new Date().toISOString().split('T')[0]
      };
      
      const queryParams = { ...defaultParams, ...params };
      console.log('📊 Final report params:', queryParams);
      
      const response = await apiMethods.getDailyReport(queryParams);
      
      if (response.success && response.data) {
        console.log('✅ Daily collection report fetched successfully:', {
          date: response.data.date,
          activities: response.data.summary?.totalActivities,
          payments: response.data.summary?.totalPayments,
          amount: response.data.summary?.totalAmountCollected
        });
        
        return {
          success: true,
          report: response.data,
          message: response.message
        };
      } else {
        throw new Error(response.message || 'Failed to fetch daily report');
      }
    } catch (error) {
      console.error('❌ Error fetching daily collection report:', error);
      
      let errorMessage = 'Failed to load daily report';
      
      if (error.response?.status === 401) {
        errorMessage = 'Authentication required. Please log in again.';
      } else if (error.response?.status === 403) {
        errorMessage = 'Access denied. You do not have permission to view reports.';
      } else if (error.response?.status === 500) {
        errorMessage = 'Server error. Please try again later.';
      } else if (error.response?.data?.error) {
        errorMessage = error.response.data.error;
      }
      
      throw new Error(errorMessage);
    }
  }

  // Search collection accounts
  async searchAccounts(searchTerm, filters = {}) {
    try {
      console.log('🔍 Searching collection accounts:', { searchTerm, filters });
      
      const params = {
        search: searchTerm,
        ...filters
      };
      
      return await this.getAccounts(params);
    } catch (error) {
      console.error('❌ Error searching collection accounts:', error);
      throw error;
    }
  }

  // Filter accounts by status
  async getAccountsByStatus(status, params = {}) {
    try {
      console.log('📋 Fetching accounts by status:', status);
      
      const queryParams = {
        status,
        ...params
      };
      
      return await this.getAccounts(queryParams);
    } catch (error) {
      console.error('❌ Error fetching accounts by status:', error);
      throw error;
    }
  }

  // Get collection statistics
  async getCollectionStats(params = {}) {
    try {
      console.log('📈 Fetching collection statistics');
      
      // This could be expanded to call a dedicated stats endpoint
      const accountsResponse = await this.getAccounts({ limit: 1, ...params });
      
      if (accountsResponse.success) {
        return {
          success: true,
          stats: accountsResponse.summary,
          message: 'Statistics retrieved successfully'
        };
      } else {
        throw new Error('Failed to fetch statistics');
      }
    } catch (error) {
      console.error('❌ Error fetching collection statistics:', error);
      throw error;
    }
  }

  // Format currency for display
  formatCurrency(amount) {
    try {
      return new Intl.NumberFormat('ar-SA', {
        style: 'currency',
        currency: 'SAR'
      }).format(amount || 0);
    } catch (error) {
      console.error('❌ Error formatting currency:', error);
      return `SAR ${amount || 0}`;
    }
  }

  // Calculate days overdue
  calculateDaysOverdue(lastPaymentDate) {
    try {
      if (!lastPaymentDate) return 0;
      
      const today = new Date();
      const lastPayment = new Date(lastPaymentDate);
      const diffTime = today - lastPayment;
      const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
      
      return Math.max(0, diffDays);
    } catch (error) {
      console.error('❌ Error calculating days overdue:', error);
      return 0;
    }
  }

  // Get status badge color
  getStatusBadgeColor(status) {
    const statusColors = {
      'new': 'blue',
      'in_progress': 'yellow',
      'resolved': 'green',
      'closed': 'gray',
      'escalated': 'red'
    };
    
    return statusColors[status?.toLowerCase()] || 'gray';
  }

  // Get priority badge color
  getPriorityBadgeColor(priority) {
    const priorityColors = {
      'low': 'green',
      'medium': 'yellow',
      'high': 'orange',
      'urgent': 'red'
    };
    
    return priorityColors[priority?.toLowerCase()] || 'gray';
  }
}

// Create and export singleton instance
const collectionService = new CollectionService();

export default collectionService;
export { collectionReportsService };

