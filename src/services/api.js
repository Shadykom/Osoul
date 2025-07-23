import axios from 'axios';

// Get API base URL from environment variables with fallback
const getApiBaseUrl = () => {
  // Try different environment variable names
  const envUrl = import.meta.env.VITE_API_URL || 
                 import.meta.env.REACT_APP_API_URL || 
                 process.env.VITE_API_URL || 
                 process.env.REACT_APP_API_URL;
  
  if (envUrl) {
    console.log('🔗 API Base URL from env:', envUrl);
    return envUrl;
  }
  
  // Production fallback
  const productionUrl = 'https://ousol-backend-dx9u.vercel.app/api/v1';
  console.log('🔗 API Base URL (fallback):', productionUrl);
  return productionUrl;
};

const API_BASE_URL = getApiBaseUrl();
console.log('🔗 API Base URL:', API_BASE_URL);

// Create axios instance
const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Token management functions
const getToken = () => {
  try {
    const token = localStorage.getItem('token') || sessionStorage.getItem('token');
    if (token) {
      console.log('🔑 Token found in storage');
      return token;
    }
    console.log('⚠️ No token found in storage');
    return null;
  } catch (error) {
    console.error('❌ Error getting token:', error);
    return null;
  }
};

const setToken = (token) => {
  try {
    localStorage.setItem('token', token);
    console.log('✅ Token saved to localStorage');
  } catch (error) {
    console.error('❌ Error saving token:', error);
  }
};

const removeToken = () => {
  try {
    localStorage.removeItem('token');
    sessionStorage.removeItem('token');
    console.log('🗑️ Token removed from storage');
  } catch (error) {
    console.error('❌ Error removing token:', error);
  }
};

// Request interceptor to add JWT token to all requests
api.interceptors.request.use(
  (config) => {
    const token = getToken();
    
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
      console.log('🔐 Added JWT token to request:', config.method?.toUpperCase(), config.url);
    } else {
      console.log('⚠️ No token available for request:', config.method?.toUpperCase(), config.url);
    }
    
    // Log request details for debugging
    console.log('📤 API Request:', {
      method: config.method?.toUpperCase(),
      url: config.url,
      baseURL: config.baseURL,
      hasToken: !!token,
      headers: config.headers
    });
    
    return config;
  },
  (error) => {
    console.error('❌ Request interceptor error:', error);
    return Promise.reject(error);
  }
);

// Response interceptor to handle authentication errors
api.interceptors.response.use(
  (response) => {
    console.log('📥 API Response:', {
      status: response.status,
      url: response.config.url,
      method: response.config.method?.toUpperCase()
    });
    return response;
  },
  (error) => {
    console.error('❌ API Response Error:', {
      status: error.response?.status,
      url: error.config?.url,
      method: error.config?.method?.toUpperCase(),
      message: error.message,
      data: error.response?.data
    });

    // Handle 401 Unauthorized errors
    if (error.response?.status === 401) {
      console.log('🚨 401 Unauthorized - Token may be invalid or expired');
      
      // Check if this is a login request (don't redirect on login failures)
      const isLoginRequest = error.config?.url?.includes('/auth/login');
      
      if (!isLoginRequest) {
        console.log('🔄 Redirecting to login due to 401 error');
        removeToken();
        
        // Redirect to login page
        if (typeof window !== 'undefined') {
          window.location.href = '/login';
        }
      }
    }

    return Promise.reject(error);
  }
);

// Connection test function
export const testConnection = async () => {
  try {
    console.log('🔍 Testing API connection...');
    console.log('📍 Base URL:', API_BASE_URL);
    
    const response = await fetch(`${API_BASE_URL.replace('/api/v1', '')}/health`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    
    if (response.ok) {
      const data = await response.json();
      console.log('✅ Connection test successful:', data);
      return { success: true, data };
    } else {
      console.log('❌ Connection test failed:', response.status, response.statusText);
      return { success: false, error: `HTTP ${response.status}` };
    }
  } catch (error) {
    console.log('❌ Connection test failed:', error.message);
    return { success: false, error: error.message };
  }
};

// API methods
export const apiMethods = {
  // Authentication
  login: async (credentials) => {
    console.log('🔐 Attempting login for:', credentials.email);
    
    // Test connection first
    const connectionTest = await testConnection();
    if (!connectionTest.success) {
      throw new Error(`Backend connection failed: ${connectionTest.error}`);
    }
    
    const response = await api.post('/auth/login', credentials);
    
    if (response.data.token) {
      setToken(response.data.token);
      console.log('✅ Login successful, token saved');
    }
    
    return response.data;
  },

  logout: () => {
    removeToken();
    console.log('👋 Logged out, token removed');
  },

  getCurrentUser: async () => {
    console.log('👤 Getting current user');
    const response = await api.get('/auth/me');
    return response.data;
  },

  // Collection APIs
  getCollectionAccounts: async (params = {}) => {
    console.log('📋 Fetching collection accounts with params:', params);
    const response = await api.get('/collection/accounts', { params });
    return response.data;
  },

  getCollectionAccount: async (id) => {
    console.log('🔍 Fetching collection account details for ID:', id);
    const response = await api.get(`/collection/accounts/${id}`);
    return response.data;
  },

  getDailyReport: async (params = {}) => {
    console.log('📊 Fetching daily collection report with params:', params);
    const response = await api.get('/collection/reports/daily', { params });
    return response.data;
  },

  // Database test
  testDatabase: async () => {
    console.log('🗄️ Testing database connection');
    const response = await api.get('/test-db');
    return response.data;
  }
};

// Export token management functions
export { getToken, setToken, removeToken };

// Export axios instance for direct use if needed
export default api;

