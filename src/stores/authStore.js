import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import authService from '../services/auth.service';

const useAuthStore = create(
  persist(
    (set, get) => {
      // Initialize auth state from service
      const initialUser = authService.getUser();
      const initialToken = authService.getAuthToken();
      const initialIsAuthenticated = authService.isLoggedIn();
      
      console.log('🏗️ authStore: Initializing with auth service state:', {
        user: initialUser?.email,
        hasToken: !!initialToken,
        isAuthenticated: initialIsAuthenticated
      });

      return {
        user: initialUser,
        token: initialToken,
        isAuthenticated: initialIsAuthenticated,
        isLoading: false,

      login: async (email, password) => {
        set({ isLoading: true });
        try {
          const response = await authService.login(email, password);
          set({
            user: response.user,
            token: response.token,
            isAuthenticated: true,
            isLoading: false,
          });
          return { success: true };
        } catch (error) {
          set({ isLoading: false });
          return { 
            success: false, 
            error: error.response?.data?.error || 'Login failed' 
          };
        }
      },

      logout: () => {
        authService.logout();
        set({
          user: null,
          token: null,
          isAuthenticated: false,
        });
      },

      updateUser: (user) => {
        set({ user });
      },

      checkAuth: async () => {
        console.log('🔍 authStore.checkAuth: Starting authentication check');
        const token = authService.getAuthToken();
        console.log('🔍 authStore.checkAuth: Token found:', !!token);
        
        if (!token) {
          console.log('🔍 authStore.checkAuth: No token, setting authenticated false');
          set({ isAuthenticated: false, user: null });
          return false;
        }

        try {
          console.log('🔍 authStore.checkAuth: Calling getCurrentUser');
          const user = await authService.getCurrentUser();
          console.log('🔍 authStore.checkAuth: getCurrentUser success, user:', user?.email);
          set({ user, isAuthenticated: true });
          return true;
        } catch (error) {
          console.error('🔍 authStore.checkAuth: getCurrentUser failed:', error.message);
          set({ isAuthenticated: false, user: null });
          return false;
        }
      },

      hasRole: (role) => {
        const { user } = get();
        return user?.role === role;
      },

              hasAnyRole: (...roles) => {
          const { user } = get();
          return roles.includes(user?.role);
        },
      };
    },
    {
      name: 'auth-storage',
      partialize: (state) => ({ 
        user: state.user, 
        token: state.token,
        isAuthenticated: state.isAuthenticated 
      }),
      onRehydrateStorage: () => (state) => {
        if (state) {
          console.log('🔄 authStore: Rehydrated from storage:', {
            user: state.user?.email,
            hasToken: !!state.token,
            isAuthenticated: state.isAuthenticated
          });
          
          // Sync auth service state with store state after rehydration
          if (state.user && state.token && state.isAuthenticated) {
            authService.user = state.user;
            authService.token = state.token;
            authService.isAuthenticated = state.isAuthenticated;
            console.log('✅ authStore: Synced auth service with rehydrated state');
          }
        }
      },
    }
  )
);

export default useAuthStore;