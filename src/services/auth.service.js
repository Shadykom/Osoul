import { apiMethods, getToken, setToken, removeToken } from './api.js';

class AuthService {
  constructor() {
    this.user = null;
    this.token = null;
    this.isAuthenticated = false;
    
    // Initialize from stored token
    this.initializeFromStorage();
  }

  // Initialize authentication state from localStorage
  initializeFromStorage() {
    try {
      const storedToken = getToken();
      const storedUser = localStorage.getItem('user');
      
      if (storedToken && storedUser) {
        this.token = storedToken;
        this.user = JSON.parse(storedUser);
        this.isAuthenticated = true;
        console.log('✅ Auth state restored from storage:', this.user?.email);
      } else {
        console.log('ℹ️ No stored auth state found');
      }
    } catch (error) {
      console.error('❌ Error initializing auth from storage:', error);
      this.clearAuthState();
    }
  }

  // Login method
  async login(email, password) {
    try {
      console.log('🔐 Attempting login for:', email);
      console.log('🌐 API Base URL:', import.meta.env.VITE_API_URL || 'fallback URL');

      // Test connection first
      console.log('🔍 Testing API connection...');
      const connectionTest = await apiMethods.testConnection?.();
      if (connectionTest && !connectionTest.success) {
        throw new Error(`Backend connection failed: ${connectionTest.error}`);
      }
      console.log('✅ Connection test passed');

      // Attempt login
      const response = await apiMethods.login({ email, password });
      
      if (response.user && response.token) {
        // Store authentication data
        this.user = response.user;
        this.token = response.token;
        this.isAuthenticated = true;
        
        // Persist to localStorage
        setToken(response.token);
        localStorage.setItem('user', JSON.stringify(response.user));
        
        console.log('✅ Login successful for:', response.user.email);
        console.log('👤 User role:', response.user.role);
        
        return {
          success: true,
          user: response.user,
          token: response.token,
          message: response.message
        };
      } else {
        throw new Error('Invalid response format from server');
      }
    } catch (error) {
      console.error('❌ Login failed:', error);
      this.clearAuthState();
      
      // Provide user-friendly error messages
      let errorMessage = 'Login failed';
      
      if (error.message.includes('Backend connection failed')) {
        errorMessage = 'Unable to connect to server. Please try again later.';
      } else if (error.response?.status === 401) {
        errorMessage = 'Invalid email or password';
      } else if (error.response?.status === 500) {
        errorMessage = 'Server error. Please try again later.';
      } else if (error.message.includes('Network Error')) {
        errorMessage = 'Network error. Please check your connection.';
      } else if (error.response?.data?.error) {
        errorMessage = error.response.data.error;
      }
      
      throw new Error(errorMessage);
    }
  }

  // Logout method
  logout() {
    console.log('👋 Logging out user:', this.user?.email);
    this.clearAuthState();
    apiMethods.logout();
    
    // Redirect to login page
    if (typeof window !== 'undefined') {
      window.location.href = '/login';
    }
  }

  // Clear authentication state
  clearAuthState() {
    this.user = null;
    this.token = null;
    this.isAuthenticated = false;
    
    // Clear localStorage
    removeToken();
    localStorage.removeItem('user');
    
    console.log('🗑️ Auth state cleared');
  }

  // Get current user
  async getCurrentUser() {
    try {
      if (!this.isAuthenticated || !this.token) {
        throw new Error('Not authenticated');
      }

      console.log('👤 Fetching current user data');
      const response = await apiMethods.getCurrentUser();
      
      if (response.user) {
        this.user = response.user;
        localStorage.setItem('user', JSON.stringify(response.user));
        console.log('✅ Current user data updated');
        return response.user;
      }
      
      throw new Error('Invalid user data received');
    } catch (error) {
      console.error('❌ Error getting current user:', error);
      
      if (error.response?.status === 401) {
        console.log('🚨 Token expired or invalid, logging out');
        this.logout();
      }
      
      throw error;
    }
  }

  // Check if user is authenticated
  isLoggedIn() {
    const hasToken = !!getToken();
    const hasUser = !!this.user;
    const isAuth = this.isAuthenticated;
    
    console.log('🔍 Auth check:', { hasToken, hasUser, isAuth });
    
    return hasToken && hasUser && isAuth;
  }

  // Get user info
  getUser() {
    return this.user;
  }

  // Get token
  getAuthToken() {
    return this.token || getToken();
  }

  // Check if user has specific role
  hasRole(role) {
    return this.user?.role === role;
  }

  // Check if user has any of the specified roles
  hasAnyRole(roles) {
    return roles.includes(this.user?.role);
  }

  // Refresh token (if needed in the future)
  async refreshToken() {
    try {
      // This would be implemented if your backend supports token refresh
      console.log('🔄 Token refresh not implemented yet');
      return false;
    } catch (error) {
      console.error('❌ Token refresh failed:', error);
      this.logout();
      return false;
    }
  }

  // Validate current session
  async validateSession() {
    try {
      if (!this.isLoggedIn()) {
        return false;
      }

      // Try to get current user to validate token
      await this.getCurrentUser();
      return true;
    } catch (error) {
      console.error('❌ Session validation failed:', error);
      return false;
    }
  }
}

// Create and export singleton instance
const authService = new AuthService();

export default authService;

