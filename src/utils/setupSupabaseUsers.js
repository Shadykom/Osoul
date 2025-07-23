import { supabase } from '@/lib/supabase';

// Demo users configuration
const demoUsers = [
  {
    email: 'admin@osoul.com',
    password: 'password123',
    firstName: 'Admin',
    lastName: 'User',
    role: 'admin'
  },
  {
    email: 'manager@osoul.com',
    password: 'password123',
    firstName: 'Manager',
    lastName: 'User',
    role: 'manager'
  },
  {
    email: 'collector1@osoul.com',
    password: 'password123',
    firstName: 'Collector',
    lastName: 'One',
    role: 'collector'
  },
  {
    email: 'viewer@osoul.com',
    password: 'password123',
    firstName: 'Viewer',
    lastName: 'User',
    role: 'viewer'
  }
];

// Function to create a user with retry logic
async function createUserWithRetry(user, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      // First try to sign up
      const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
        email: user.email,
        password: user.password,
        options: {
          data: {
            firstName: user.firstName,
            lastName: user.lastName,
            role: user.role
          }
        }
      });

      if (signUpError) {
        // If user already exists, try to get their ID
        if (signUpError.message.includes('already registered')) {
          console.log(`User ${user.email} already exists, checking profile...`);
          
          // Try to sign in to get the user ID
          const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
            email: user.email,
            password: user.password
          });

          if (!signInError && signInData.user) {
            // Check if profile exists
            const { data: profile, error: profileError } = await supabase
              .from('users')
              .select('*')
              .eq('id', signInData.user.id)
              .single();

            if (profileError && profileError.code === 'PGRST116') {
              // Profile doesn't exist, create it
              const { error: insertError } = await supabase
                .from('users')
                .insert({
                  id: signInData.user.id,
                  email: user.email,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  role: user.role,
                  isActive: true
                });

              if (!insertError) {
                console.log(`✅ Created profile for existing user: ${user.email}`);
                return { success: true, message: 'Profile created for existing user' };
              }
            } else if (!profileError) {
              console.log(`✅ User ${user.email} already has a profile`);
              return { success: true, message: 'User and profile already exist' };
            }
          }
          
          // If we can't sign in, the password might be different
          return { 
            success: false, 
            message: `User exists but can't sign in. Password might be different.`,
            needsPasswordReset: true
          };
        }
        
        throw signUpError;
      }

      // If sign up successful, create profile
      if (signUpData.user) {
        const { error: profileError } = await supabase
          .from('users')
          .insert({
            id: signUpData.user.id,
            email: user.email,
            firstName: user.firstName,
            lastName: user.lastName,
            role: user.role,
            isActive: true
          });

        if (!profileError) {
          console.log(`✅ Successfully created user: ${user.email}`);
          return { success: true, message: 'User created successfully' };
        } else {
          console.error(`Profile creation error for ${user.email}:`, profileError);
        }
      }

    } catch (error) {
      console.error(`Attempt ${i + 1} failed for ${user.email}:`, error);
      if (i === retries - 1) {
        return { success: false, error: error.message };
      }
      // Wait before retry
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }
}

// Main setup function
export async function setupDemoUsers() {
  console.log('🚀 Starting demo users setup...');
  const results = [];

  for (const user of demoUsers) {
    console.log(`\nProcessing user: ${user.email}`);
    const result = await createUserWithRetry(user);
    results.push({
      email: user.email,
      ...result
    });
  }

  // Summary
  console.log('\n📊 Setup Summary:');
  results.forEach(result => {
    if (result.success) {
      console.log(`✅ ${result.email}: ${result.message}`);
    } else {
      console.log(`❌ ${result.email}: ${result.error || result.message}`);
    }
  });

  return results;
}

// Function to test login for all demo users
export async function testDemoUsersLogin() {
  console.log('🧪 Testing login for all demo users...');
  const results = [];

  for (const user of demoUsers) {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email: user.email,
        password: user.password
      });

      if (error) {
        results.push({
          email: user.email,
          success: false,
          error: error.message
        });
      } else {
        // Check profile
        const { data: profile, error: profileError } = await supabase
          .from('users')
          .select('*')
          .eq('id', data.user.id)
          .single();

        results.push({
          email: user.email,
          success: true,
          hasProfile: !profileError,
          role: profile?.role
        });

        // Sign out after test
        await supabase.auth.signOut();
      }
    } catch (error) {
      results.push({
        email: user.email,
        success: false,
        error: error.message
      });
    }
  }

  // Summary
  console.log('\n📊 Test Results:');
  results.forEach(result => {
    if (result.success) {
      console.log(`✅ ${result.email}: Can login (Profile: ${result.hasProfile ? 'Yes' : 'No'}, Role: ${result.role})`);
    } else {
      console.log(`❌ ${result.email}: ${result.error}`);
    }
  });

  return results;
}

// Function to reset password for a user
export async function resetUserPassword(email) {
  try {
    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/reset-password`,
    });
    
    if (error) throw error;
    
    console.log(`✅ Password reset email sent to ${email}`);
    return { success: true, message: 'Password reset email sent' };
  } catch (error) {
    console.error(`❌ Error resetting password for ${email}:`, error);
    return { success: false, error: error.message };
  }
}