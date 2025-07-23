import { createClient } from '@supabase/supabase-js';

// Supabase configuration
const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://mrecphuxcweignmdytal.supabase.co';
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY';

// Validate configuration
if (!supabaseUrl) {
  throw new Error('Missing VITE_SUPABASE_URL environment variable');
}

if (!supabaseAnonKey) {
  throw new Error('Missing VITE_SUPABASE_ANON_KEY environment variable');
}

console.log('🔧 Supabase Configuration:', {
  url: supabaseUrl,
  hasAnonKey: !!supabaseAnonKey,
  keyPreview: supabaseAnonKey.substring(0, 20) + '...'
});

// Create Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true,
    flowType: 'pkce'
  },
  db: {
    schema: 'public'
  },
  global: {
    headers: {
      'X-Client-Info': 'osoul-collection-system'
    }
  }
});

// Test connection function
export const testSupabaseConnection = async () => {
  try {
    console.log('🔍 Testing Supabase connection...');
    
    // Test basic connection
    const { data, error } = await supabase
      .from('users')
      .select('count(*)')
      .limit(1);

    if (error) {
      console.error('❌ Supabase connection test failed:', error);
      return {
        success: false,
        error: error.message,
        details: error
      };
    }

    console.log('✅ Supabase connection test successful');
    return {
      success: true,
      message: 'Supabase connection successful',
      data: data
    };
  } catch (error) {
    console.error('❌ Supabase connection test error:', error);
    return {
      success: false,
      error: error.message
    };
  }
};

// Export configuration values for debugging
export const supabaseConfig = {
  url: supabaseUrl,
  anonKey: supabaseAnonKey,
  hasValidConfig: !!(supabaseUrl && supabaseAnonKey)
};

export default supabase;

