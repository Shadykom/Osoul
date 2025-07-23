// Script to create demo users in Supabase
// Run this with: node supabase-create-users.js

import { createClient } from '@supabase/supabase-js';

// Use the same configuration as your app
const supabaseUrl = 'https://mrecphuxcweignmdytal.supabase.co';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY; // You need the service key for admin operations

if (!supabaseServiceKey) {
  console.error('❌ Error: SUPABASE_SERVICE_KEY environment variable is required');
  console.log('Please set it with: export SUPABASE_SERVICE_KEY="your-service-key"');
  console.log('You can find the service key in your Supabase project settings > API');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

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

async function createUsers() {
  console.log('🚀 Starting user creation...\n');

  for (const user of demoUsers) {
    try {
      console.log(`Creating user: ${user.email}`);
      
      // First, create the auth user
      const { data: authData, error: authError } = await supabase.auth.admin.createUser({
        email: user.email,
        password: user.password,
        email_confirm: true,
        user_metadata: {
          firstName: user.firstName,
          lastName: user.lastName,
          role: user.role
        }
      });

      if (authError) {
        if (authError.message.includes('already been registered')) {
          console.log(`⚠️  User ${user.email} already exists in auth`);
          
          // Get the existing user
          const { data: { users }, error: listError } = await supabase.auth.admin.listUsers();
          if (!listError) {
            const existingUser = users.find(u => u.email === user.email);
            if (existingUser) {
              // Update the user profile in the database
              const { error: profileError } = await supabase
                .from('users')
                .upsert({
                  id: existingUser.id,
                  email: user.email,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  role: user.role,
                  isActive: true
                }, {
                  onConflict: 'id'
                });

              if (profileError) {
                console.error(`❌ Error updating profile for ${user.email}:`, profileError);
              } else {
                console.log(`✅ Updated profile for ${user.email}`);
              }
            }
          }
        } else {
          console.error(`❌ Error creating ${user.email}:`, authError);
        }
        continue;
      }

      console.log(`✅ Created auth user: ${user.email}`);

      // Then create the user profile in the database
      const { error: profileError } = await supabase
        .from('users')
        .insert({
          id: authData.user.id,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          role: user.role,
          isActive: true
        });

      if (profileError) {
        console.error(`❌ Error creating profile for ${user.email}:`, profileError);
      } else {
        console.log(`✅ Created profile for ${user.email}`);
      }

      console.log('---');
    } catch (error) {
      console.error(`❌ Unexpected error for ${user.email}:`, error);
    }
  }

  console.log('\n✨ User creation process completed!');
  console.log('\nYou can now login with:');
  demoUsers.forEach(user => {
    console.log(`  ${user.role}: ${user.email} / ${user.password}`);
  });
}

createUsers().catch(console.error);