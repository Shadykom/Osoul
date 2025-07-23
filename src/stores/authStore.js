import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { supabaseAuth } from '@/services/supabaseAuth';

const useAuthStore = create(
  persist(
    (set, get) => ({
      // State
      user: null,
      session: null,
      isAuthenticated: false,
      isLoading: false,
      error: null,

      // Actions
      login: async (email, password) => {
        console.log('🔐 authStore.login: Starting login process for:', email);
        set({ isLoading: true, error: null });

        try {
          const result = await supabaseAuth.login(email, password);
          
          if (result.success) {
            console.log('✅ authStore.login: Login successful, updating store');
            set({
              user: result.user,
              session: result.session,
              isAuthenticated: true,
              isLoading: false,
              error: null,
            });
            
            return { success: true, user: result.user };
          } else {
            console.error('❌ authStore.login: Login failed:', result.error);
            set({
              user: null,
              session: null,
              isAuthenticated: false,
              isLoading: false,
              error: result.error,
            });
            
            return { success: false, error: result.error };
          }
        } catch (error) {
          console.error('❌ authStore.login: Unexpected error:', error);
          set({
            user: null,
            session: null,
            isAuthenticated: false,
            isLoading: false,
            error: error.message,
          });
          
          return { success: false, error: error.message };
        }
      },

      logout: async () => {
        console.log('👋 authStore.logout: Starting logout process');
        set({ isLoading: true });

        try {
          const result = await supabaseAuth.logout();
          
          console.log('✅ authStore.logout: Logout completed, clearing store');
          set({
            user: null,
            session: null,
            isAuthenticated: false,
            isLoading: false,
            error: null,
          });
          
          return { success: true };
        } catch (error) {
          console.error('❌ authStore.logout: Error during logout:', error);
          set({ isLoading: false, error: error.message });
          return { success: false, error: error.message };
        }
      },

      getCurrentUser: async () => {
        console.log('👤 authStore.getCurrentUser: Fetching current user');
        set({ isLoading: true, error: null });

        try {
          const result = await supabaseAuth.getCurrentUser();
          
          if (result.success) {
            console.log('✅ authStore.getCurrentUser: User retrieved successfully');
            set({
              user: result.user,
              session: result.session,
              isAuthenticated: true,
              isLoading: false,
              error: null,
            });
            
            return { success: true, user: result.user };
          } else {
            console.log('ℹ️ authStore.getCurrentUser: No authenticated user');
            set({
              user: null,
              session: null,
              isAuthenticated: false,
              isLoading: false,
              error: null,
            });
            
            return { success: false, error: result.error };
          }
        } catch (error) {
          console.error('❌ authStore.getCurrentUser: Error:', error);
          set({
            user: null,
            session: null,
            isAuthenticated: false,
            isLoading: false,
            error: error.message,
          });
          
          return { success: false, error: error.message };
        }
      },

      // Initialize auth state from Supabase session
      initializeAuth: async () => {
        console.log('🔄 authStore.initializeAuth: Initializing auth state');
        set({ isLoading: true, error: null });

        try {
          const session = await supabaseAuth.getSession();
          
          if (session) {
            console.log('✅ authStore.initializeAuth: Found existing session');
            const result = await supabaseAuth.getCurrentUser();
            
            if (result.success) {
              set({
                user: result.user,
                session: result.session,
                isAuthenticated: true,
                isLoading: false,
                error: null,
              });
              
              console.log('✅ authStore.initializeAuth: Auth state restored');
              return { success: true, user: result.user };
            }
          }
          
          console.log('ℹ️ authStore.initializeAuth: No existing session');
          set({
            user: null,
            session: null,
            isAuthenticated: false,
            isLoading: false,
            error: null,
          });
          
          return { success: false, error: 'No session found' };
        } catch (error) {
          console.error('❌ authStore.initializeAuth: Error:', error);
          set({
            user: null,
            session: null,
            isAuthenticated: false,
            isLoading: false,
            error: error.message,
          });
          
          return { success: false, error: error.message };
        }
      },

      // Clear error
      clearError: () => {
        set({ error: null });
      },

      // Set loading state
      setLoading: (loading) => {
        set({ isLoading: loading });
      },

      // Check if user has specific role
      hasRole: (role) => {
        const { user } = get();
        return user?.role === role;
      },

      // Check if user has any of the specified roles
      hasAnyRole: (roles) => {
        const { user } = get();
        return roles.includes(user?.role);
      },

      // Get user permissions based on role
      getPermissions: () => {
        const { user } = get();
        if (!user) return [];

        const rolePermissions = {
          admin: ['read', 'write', 'delete', 'manage_users', 'view_reports', 'manage_settings'],
          manager: ['read', 'write', 'view_reports', 'manage_team'],
          collector: ['read', 'write', 'update_cases'],
          viewer: ['read'],
        };

        return rolePermissions[user.role] || [];
      },

      // Check if user has specific permission
      hasPermission: (permission) => {
        const permissions = get().getPermissions();
        return permissions.includes(permission);
      },

      // Update user profile
      updateUser: (userData) => {
        const { user } = get();
        if (user) {
          const updatedUser = { ...user, ...userData };
          set({ user: updatedUser });
          console.log('✅ authStore.updateUser: User profile updated');
        }
      },

      // Set up auth state listener
      setupAuthListener: () => {
        console.log('👂 authStore.setupAuthListener: Setting up auth state listener');
        
        return supabaseAuth.onAuthStateChange((event, session) => {
          console.log('🔄 authStore: Auth state changed:', event);
          
          if (event === 'SIGNED_IN' && session) {
            console.log('✅ authStore: User signed in, updating state');
            get().getCurrentUser();
          } else if (event === 'SIGNED_OUT') {
            console.log('👋 authStore: User signed out, clearing state');
            set({
              user: null,
              session: null,
              isAuthenticated: false,
              error: null,
            });
          } else if (event === 'TOKEN_REFRESHED' && session) {
            console.log('🔄 authStore: Token refreshed, updating session');
            set({ session });
          }
        });
      },
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({
        user: state.user,
        isAuthenticated: state.isAuthenticated,
      }),
      onRehydrateStorage: () => (state) => {
        console.log('💾 authStore: Rehydrating from storage');
        if (state?.isAuthenticated) {
          console.log('🔄 authStore: Found stored auth state, initializing...');
          state.initializeAuth();
        }
      },
    }
  )
);

export { useAuthStore };

