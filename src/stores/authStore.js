import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import supabaseAuth from '../services/supabaseAuth';

const useAuthStore = create(
  persist(
    (set, get) => ({
      user: null,
      session: null,
      isAuthenticated: false,
      isLoading: false,

      // Initialize auth state
      initialize: async () => {
        try {
          console.log('🏗️ authStore: Initializing...');
          const session = await supabaseAuth.getSession();
          
          if (session) {
            const user = await supabaseAuth.getCurrentUser();
            if (user) {
              set({
                user,
                session,
                isAuthenticated: true,
              });
              console.log('✅ authStore: Initialized with user:', user.email);
            }
          }
        } catch (error) {
          console.error('❌ authStore: Initialization error:', error);
        }
      },

      // Login
      login: async (email, password) => {
        set({ isLoading: true });
        try {
          const { user, session } = await supabaseAuth.login(email, password);
          set({
            user,
            session,
            isAuthenticated: true,
            isLoading: false,
          });
          console.log('✅ authStore: Login successful:', user.email);
          return { success: true };
        } catch (error) {
          set({ isLoading: false });
          console.error('❌ authStore: Login error:', error);
          return { 
            success: false, 
            error: error.message || 'Login failed' 
          };
        }
      },

      // Logout
      logout: async () => {
        try {
          await supabaseAuth.logout();
          set({
            user: null,
            session: null,
            isAuthenticated: false,
          });
          console.log('✅ authStore: Logout successful');
        } catch (error) {
          console.error('❌ authStore: Logout error:', error);
        }
      },

      // Update user
      updateUser: (user) => {
        set({ user });
      },

      // Check authentication
      checkAuth: async () => {
        console.log('🔍 authStore.checkAuth: Starting authentication check');
        
        try {
          const session = await supabaseAuth.getSession();
          
          if (!session) {
            console.log('🔍 authStore.checkAuth: No session found');
            set({ isAuthenticated: false, user: null, session: null });
            return false;
          }

          const user = await supabaseAuth.getCurrentUser();
          
          if (!user) {
            console.log('🔍 authStore.checkAuth: No user found');
            set({ isAuthenticated: false, user: null, session: null });
            return false;
          }

          console.log('🔍 authStore.checkAuth: User authenticated:', user.email);
          set({ user, session, isAuthenticated: true });
          return true;
        } catch (error) {
          console.error('🔍 authStore.checkAuth: Error:', error);
          set({ isAuthenticated: false, user: null, session: null });
          return false;
        }
      },

      // Check if user has role
      hasRole: (role) => {
        const { user } = get();
        return user?.role === role;
      },

      // Check if user has any of the roles
      hasAnyRole: (...roles) => {
        const { user } = get();
        return roles.includes(user?.role);
      },

      // Update user profile
      updateProfile: async (updates) => {
        const { user } = get();
        if (!user) return { success: false, error: 'No user logged in' };

        try {
          const updatedUser = await supabaseAuth.updateUserProfile(user.id, updates);
          set({ user: updatedUser });
          return { success: true, user: updatedUser };
        } catch (error) {
          console.error('❌ authStore: Update profile error:', error);
          return { success: false, error: error.message };
        }
      },

      // Reset password
      resetPassword: async (email) => {
        try {
          await supabaseAuth.resetPassword(email);
          return { success: true };
        } catch (error) {
          console.error('❌ authStore: Reset password error:', error);
          return { success: false, error: error.message };
        }
      },
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({ 
        user: state.user,
        isAuthenticated: state.isAuthenticated 
      }),
    }
  )
);

// Initialize auth on store creation
useAuthStore.getState().initialize();

// Listen to auth state changes
supabaseAuth.onAuthStateChange(async (event, session) => {
  console.log('🔄 Auth state changed:', event);
  
  if (event === 'SIGNED_IN' && session) {
    const user = await supabaseAuth.getCurrentUser();
    if (user) {
      useAuthStore.setState({
        user,
        session,
        isAuthenticated: true,
      });
    }
  } else if (event === 'SIGNED_OUT') {
    useAuthStore.setState({
      user: null,
      session: null,
      isAuthenticated: false,
    });
  }
});

export default useAuthStore;