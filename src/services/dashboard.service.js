import api from './api';

class DashboardService {
  async getDashboards() {
    const response = await api.get('/dashboards');
    return response.data;
  }

  async getDashboardById(id) {
    const response = await api.get(`/dashboards/${id}`);
    return response.data;
  }

  async createDashboard(data) {
    const response = await api.post('/dashboards', data);
    return response.data;
  }

  async updateDashboard(id, data) {
    const response = await api.put(`/dashboards/${id}`, data);
    return response.data;
  }

  async deleteDashboard(id) {
    const response = await api.delete(`/dashboards/${id}`);
    return response.data;
  }

  async addWidget(dashboardId, widgetData) {
    const response = await api.post(`/dashboards/${dashboardId}/widgets`, widgetData);
    return response.data;
  }

  async updateWidget(dashboardId, widgetId, data) {
    const response = await api.put(`/dashboards/${dashboardId}/widgets/${widgetId}`, data);
    return response.data;
  }

  async deleteWidget(dashboardId, widgetId) {
    const response = await api.delete(`/dashboards/${dashboardId}/widgets/${widgetId}`);
    return response.data;
  }

  async getWidgetData(widgetId, params = {}) {
    const response = await api.get(`/dashboards/widgets/${widgetId}/data`, { params });
    return response.data;
  }
}

export default new DashboardService();