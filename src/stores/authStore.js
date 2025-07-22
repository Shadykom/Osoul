import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import authService from '../services/auth.service';

const useAuthStore = create(
  persist(
    (set, get) => ({
      user: null,
      token: null,
      isAuthenticated: false,
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
        const token = authService.getToken();
        if (!token) {
          set({ isAuthenticated: false, user: null });
          return false;
        }

        try {
          const user = await authService.getCurrentUser();
          set({ user, isAuthenticated: true });
          return true;
        } catch (error) {
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
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({ 
        user: state.user, 
        token: state.token,
        isAuthenticated: state.isAuthenticated 
      }),
    }
  )
);

export default useAuthStore;