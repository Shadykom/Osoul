import api from './api';

class CollectionService {
  async getTransactions(params = {}) {
    const response = await api.get('/collections', { params });
    return response.data;
  }

  async getTransactionById(id) {
    const response = await api.get(`/collections/${id}`);
    return response.data;
  }

  async createTransaction(data) {
    const response = await api.post('/collections', data);
    return response.data;
  }

  async updateTransaction(id, data) {
    const response = await api.put(`/collections/${id}`, data);
    return response.data;
  }

  async deleteTransaction(id) {
    const response = await api.delete(`/collections/${id}`);
    return response.data;
  }

  async getTargets(branchId, year) {
    const params = year ? { year } : {};
    const response = await api.get(`/collections/targets/${branchId}`, { params });
    return response.data;
  }

  async setTarget(data) {
    const response = await api.post('/collections/targets', data);
    return response.data;
  }
}

export default new CollectionService();