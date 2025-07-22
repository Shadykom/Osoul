import api from './api';

class ReportService {
  async getMonthlyComparison(year, branchId) {
    const params = { year };
    if (branchId) params.branchId = branchId;
    
    const response = await api.get('/reports/monthly-comparison', { params });
    return response.data;
  }

  async getQuarterlyComparison(year, branchId) {
    const params = { year };
    if (branchId) params.branchId = branchId;
    
    const response = await api.get('/reports/quarterly-comparison', { params });
    return response.data;
  }

  async getBranchComparison(startDate, endDate, region) {
    const params = { startDate, endDate };
    if (region) params.region = region;
    
    const response = await api.get('/reports/branch-comparison', { params });
    return response.data;
  }

  async getPerformanceTrends(params) {
    const response = await api.get('/reports/performance-trends', { params });
    return response.data;
  }

  async getTopPerformers(startDate, endDate, limit = 10) {
    const response = await api.get('/reports/top-performers', {
      params: { startDate, endDate, limit }
    });
    return response.data;
  }

  async getSummary(startDate, endDate, branchId) {
    const params = {};
    if (startDate) params.startDate = startDate;
    if (endDate) params.endDate = endDate;
    if (branchId) params.branchId = branchId;
    
    const response = await api.get('/reports/summary', { params });
    return response.data;
  }

  async exportReport(reportType, format, params) {
    const response = await api.get('/reports/export', {
      params: { reportType, format, ...params },
      responseType: format === 'csv' ? 'blob' : 'json'
    });
    return response.data;
  }
}

export default new ReportService();