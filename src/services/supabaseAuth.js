import { supabase } from '@/lib/supabase';

export const supabaseAuth = {
  // Login with email and password
  async login(email, password) {
    try {
      console.log('🔐 supabaseAuth.login: Attempting login for:', email);
      
      // Sign in with Supabase Auth
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      
      console.log('🔐 supabaseAuth.login: Auth response:', { data, error });

      if (error) throw error;

      // Get user profile from users table
      const { data: userProfile, error: profileError } = await supabase
        .from('users')
        .select('*')
        .eq('email', email)
        .single();

      console.log('👤 supabaseAuth.login: Profile response:', { userProfile, profileError });

      if (profileError) {
        console.log('⚠️ Profile error, checking if user exists in auth but not in users table');
        
        // If profile doesn't exist, create one
        if (profileError.code === 'PGRST116') {
          console.log('🔧 Creating new user profile...');
          const { data: newProfile, error: createError } = await supabase
            .from('users')
            .insert([
              {
                id: data.user.id,
                email: email,
                role: 'viewer', // Default role
                first_name: email.split('@')[0],
                last_name: '',
                created_at: new Date().toISOString(),
                updated_at: new Date().toISOString(),
              }
            ])
            .select()
            .single();

          if (createError) {
            console.error('❌ Error creating user profile:', createError);
            throw new Error('Failed to create user profile: ' + createError.message);
          }

          console.log('✅ New user profile created:', newProfile);
          return {
            success: true,
            user: newProfile,
            session: data.session,
            message: 'Login successful - new profile created'
          };
        } else {
          throw new Error('Failed to fetch user profile: ' + profileError.message);
        }
      }

      console.log('✅ Login successful for user:', userProfile);
      return {
        success: true,
        user: userProfile,
        session: data.session,
        message: 'Login successful'
      };

    } catch (error) {
      console.error('❌ supabaseAuth.login error:', error);
      
      // Provide user-friendly error messages
      let errorMessage = 'Login failed';
      
      if (error.message.includes('Invalid login credentials')) {
        errorMessage = 'Invalid email or password';
      } else if (error.message.includes('Email not confirmed')) {
        errorMessage = 'Please confirm your email address';
      } else if (error.message.includes('Too many requests')) {
        errorMessage = 'Too many login attempts. Please try again later.';
      } else if (error.message.includes('Network')) {
        errorMessage = 'Network error. Please check your connection.';
      } else if (error.message) {
        errorMessage = error.message;
      }

      return {
        success: false,
        error: errorMessage,
        user: null,
        session: null
      };
    }
  },

  // Logout
  async logout() {
    try {
      console.log('👋 supabaseAuth.logout: Signing out...');
      const { error } = await supabase.auth.signOut();
      
      if (error) throw error;
      
      console.log('✅ Logout successful');
      return {
        success: true,
        message: 'Logout successful'
      };
    } catch (error) {
      console.error('❌ supabaseAuth.logout error:', error);
      return {
        success: false,
        error: error.message
      };
    }
  },

  // Get current user
  async getCurrentUser() {
    try {
      console.log('👤 supabaseAuth.getCurrentUser: Getting current user...');
      
      // Get current session
      const { data: { session }, error: sessionError } = await supabase.auth.getSession();
      
      if (sessionError) throw sessionError;
      
      if (!session) {
        console.log('ℹ️ No active session found');
        return {
          success: false,
          error: 'No active session',
          user: null,
          session: null
        };
      }

      // Get user profile
      const { data: userProfile, error: profileError } = await supabase
        .from('users')
        .select('*')
        .eq('email', session.user.email)
        .single();

      if (profileError) {
        console.error('❌ Error fetching user profile:', profileError);
        throw new Error('Failed to fetch user profile: ' + profileError.message);
      }

      console.log('✅ Current user retrieved:', userProfile);
      return {
        success: true,
        user: userProfile,
        session: session,
        message: 'User retrieved successfully'
      };

    } catch (error) {
      console.error('❌ supabaseAuth.getCurrentUser error:', error);
      return {
        success: false,
        error: error.message,
        user: null,
        session: null
      };
    }
  },

  // Check if user is authenticated
  async isAuthenticated() {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      return !!session;
    } catch (error) {
      console.error('❌ supabaseAuth.isAuthenticated error:', error);
      return false;
    }
  },

  // Get session
  async getSession() {
    try {
      const { data: { session }, error } = await supabase.auth.getSession();
      if (error) throw error;
      return session;
    } catch (error) {
      console.error('❌ supabaseAuth.getSession error:', error);
      return null;
    }
  },

  // Listen to auth changes
  onAuthStateChange(callback) {
    return supabase.auth.onAuthStateChange((event, session) => {
      console.log('🔄 Auth state changed:', event, session?.user?.email);
      callback(event, session);
    });
  },

  // Test connection to Supabase
  async testConnection() {
    try {
      console.log('🔍 Testing Supabase connection...');
      
      // Test database connection by querying users table
      const { data, error } = await supabase
        .from('users')
        .select('count(*)')
        .limit(1);

      if (error) throw error;

      console.log('✅ Supabase connection test successful');
      return {
        success: true,
        message: 'Supabase connection successful',
        data: data
      };
    } catch (error) {
      console.error('❌ Supabase connection test failed:', error);
      return {
        success: false,
        error: error.message
      };
    }
  },

  // Sign up new user (for future use)
  async signUp(email, password, userData = {}) {
    try {
      console.log('📝 supabaseAuth.signUp: Creating new user:', email);
      
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: userData
        }
      });

      if (error) throw error;

      console.log('✅ Sign up successful:', data);
      return {
        success: true,
        user: data.user,
        session: data.session,
        message: 'Sign up successful'
      };
    } catch (error) {
      console.error('❌ supabaseAuth.signUp error:', error);
      return {
        success: false,
        error: error.message,
        user: null,
        session: null
      };
    }
  },

  // Reset password
  async resetPassword(email) {
    try {
      console.log('🔄 supabaseAuth.resetPassword: Sending reset email to:', email);
      
      const { error } = await supabase.auth.resetPasswordForEmail(email);
      
      if (error) throw error;
      
      console.log('✅ Password reset email sent');
      return {
        success: true,
        message: 'Password reset email sent'
      };
    } catch (error) {
      console.error('❌ supabaseAuth.resetPassword error:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
};

export default supabaseAuth;

