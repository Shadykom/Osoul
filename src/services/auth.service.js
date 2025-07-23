import api, { testConnection } from './api';

class AuthService {
  async login(email, password) {
    try {
      console.log('🔐 Attempting login for:', email);
      console.log('🌐 API Base URL:', api.defaults.baseURL);
      
      // Test connection first
      const connectionTest = await testConnection();
      if (!connectionTest.success) {
        throw new Error(`Backend connection failed: ${connectionTest.error}`);
      }
      
      const response = await api.post('/auth/login', { email, password });
      const { user, token } = response.data;
      
      // Store token and user info
      localStorage.setItem('authToken', token);
      localStorage.setItem('user', JSON.stringify(user));
      
      console.log('✅ Login successful for:', user.email);
      return { user, token };
    } catch (error) {
      console.error('❌ Login failed:', error);
      
      // Provide user-friendly error messages
      if (error.response?.status === 401) {
        throw new Error('Invalid email or password');
      } else if (error.response?.status === 429) {
        throw new Error('Too many login attempts. Please try again later.');
      } else if (error.code === 'ERR_NETWORK') {
        throw new Error('Unable to connect to server. Please check your internet connection.');
      } else if (error.message.includes('Backend connection failed')) {
        throw error; // Re-throw connection errors as-is
      } else {
        throw new Error(error.response?.data?.message || 'Login failed. Please try again.');
      }
    }
  }

  async register(userData) {
    try {
      console.log('📝 Attempting registration for:', userData.email);
      
      const response = await api.post('/auth/register', userData);
      const { user, token } = response.data;
      
      // Store token and user info
      localStorage.setItem('authToken', token);
      localStorage.setItem('user', JSON.stringify(user));
      
      console.log('✅ Registration successful for:', user.email);
      return { user, token };
    } catch (error) {
      console.error('❌ Registration failed:', error);
      
      if (error.response?.status === 409) {
        throw new Error('Email already exists');
      } else if (error.response?.status === 400) {
        throw new Error(error.response.data.message || 'Invalid registration data');
      } else {
        throw new Error('Registration failed. Please try again.');
      }
    }
  }

  async getCurrentUser() {
    try {
      const response = await api.get('/auth/me');
      return response.data.user;
    } catch (error) {
      console.error('❌ Get current user failed:', error);
      
      // If unauthorized, clear stored data
      if (error.response?.status === 401) {
        this.logout();
      }
      
      throw error;
    }
  }

  logout() {
    console.log('👋 Logging out user');
    localStorage.removeItem('authToken');
    localStorage.removeItem('user');
  }

  getCurrentUserFromStorage() {
    try {
      const userStr = localStorage.getItem('user');
      return userStr ? JSON.parse(userStr) : null;
    } catch (error) {
      console.error('❌ Error parsing user from storage:', error);
      return null;
    }
  }

  getToken() {
    return localStorage.getItem('authToken');
  }

  isAuthenticated() {
    const token = this.getToken();
    const user = this.getCurrentUserFromStorage();
    return !!(token && user);
  }

  // Test backend connectivity
  async testBackendConnection() {
    try {
      console.log('🔍 Testing backend connection...');
      const result = await testConnection();
      
      if (result.success) {
        console.log('✅ Backend is reachable');
        return true;
      } else {
        console.error('❌ Backend is not reachable:', result.error);
        return false;
      }
    } catch (error) {
      console.error('❌ Backend connection test failed:', error);
      return false;
    }
  }
}

export default new AuthService();

