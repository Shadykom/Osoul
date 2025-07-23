import { createClient } from '@supabase/supabase-js';

// Supabase configuration
const supabaseUrl = 'https://mrecphuxcweignmdytal.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY';

// Create and export Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false
  }
});

// Auth helper functions
export const authHelpers = {
  // Sign up new user
  async signUp(email, password, userData = {}) {
    try {
      console.log('🔐 Signing up user:', email);
      
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: userData
        }
      });

      if (error) {
        console.error('❌ Signup error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Signup successful:', data);
      return { success: true, data };
    } catch (error) {
      console.error('❌ Signup exception:', error);
      return { success: false, error: error.message };
    }
  },

  // Sign in user
  async signIn(email, password) {
    try {
      console.log('🔐 Signing in user:', email);
      
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (error) {
        console.error('❌ Signin error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Signin successful:', data);
      return { success: true, data };
    } catch (error) {
      console.error('❌ Signin exception:', error);
      return { success: false, error: error.message };
    }
  },

  // Sign out user
  async signOut() {
    try {
      console.log('🔐 Signing out user');
      
      const { error } = await supabase.auth.signOut();

      if (error) {
        console.error('❌ Signout error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Signout successful');
      return { success: true };
    } catch (error) {
      console.error('❌ Signout exception:', error);
      return { success: false, error: error.message };
    }
  },

  // Get current user
  getCurrentUser() {
    const { data: { user } } = supabase.auth.getUser();
    return user;
  },

  // Get current session
  getCurrentSession() {
    const { data: { session } } = supabase.auth.getSession();
    return session;
  },

  // Listen to auth changes
  onAuthStateChange(callback) {
    return supabase.auth.onAuthStateChange(callback);
  }
};

// Database helper functions
export const dbHelpers = {
  // Create user profile
  async createUserProfile(userId, userData) {
    try {
      console.log('📝 Creating user profile:', userId);
      
      const { data, error } = await supabase
        .from('users')
        .insert([
          {
            id: userId,
            email: userData.email,
            role: userData.role || 'viewer',
            first_name: userData.first_name || userData.email?.split('@')[0] || '',
            last_name: userData.last_name || '',
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
          }
        ])
        .select()
        .single();

      if (error) {
        console.error('❌ Profile creation error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Profile created:', data);
      return { success: true, data };
    } catch (error) {
      console.error('❌ Profile creation exception:', error);
      return { success: false, error: error.message };
    }
  },

  // Get user profile
  async getUserProfile(userId) {
    try {
      console.log('👤 Getting user profile:', userId);
      
      const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('id', userId)
        .single();

      if (error) {
        console.error('❌ Profile fetch error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Profile fetched:', data);
      return { success: true, data };
    } catch (error) {
      console.error('❌ Profile fetch exception:', error);
      return { success: false, error: error.message };
    }
  },

  // Test database connection
  async testConnection() {
    try {
      console.log('🔍 Testing database connection');
      
      const { data, error } = await supabase
        .from('users')
        .select('count(*)')
        .limit(1);

      if (error) {
        console.error('❌ Connection test error:', error);
        return { success: false, error: error.message };
      }

      console.log('✅ Connection test successful:', data);
      return { success: true, data };
    } catch (error) {
      console.error('❌ Connection test exception:', error);
      return { success: false, error: error.message };
    }
  }
};

export default supabase;

