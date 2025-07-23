# Fix Console Errors Guide

## Issues Identified

1. **Ethereum Provider Conflicts** - Multiple wallet extensions (MetaMask, etc.) trying to inject their providers
2. **Supabase Authentication Error** - "Invalid login credentials" (400 error)
3. **Missing User Accounts** - Demo users not created in Supabase Auth

## Solutions Applied

### 1. Fixed Ethereum Provider Conflicts ✅

Updated `index.html` with a comprehensive solution that:
- Stores only the first ethereum provider that gets injected
- Prevents property redefinition errors
- Uses a proxy to handle multiple wallet extensions gracefully
- Intercepts `Object.defineProperty` calls to prevent conflicts

### 2. Fix Supabase Authentication

The authentication error occurs because the demo users haven't been created in Supabase Auth.

#### Option A: Create Users via Supabase Dashboard (Recommended)

1. Go to your Supabase project: https://app.supabase.com/project/mrecphuxcweignmdytal
2. Navigate to Authentication > Users
3. Click "Add user" and create each user with:
   - **Admin**: admin@osoul.com / password123
   - **Manager**: manager@osoul.com / password123
   - **Collector**: collector1@osoul.com / password123
   - **Viewer**: viewer@osoul.com / password123
4. Make sure to check "Auto Confirm User" for each

#### Option B: Use the Script (Requires Service Key)

1. Get your service key from Supabase:
   - Go to Settings > API in your Supabase project
   - Copy the `service_role` key (keep it secret!)

2. Run the user creation script:
   ```bash
   export SUPABASE_SERVICE_KEY="your-service-role-key-here"
   node supabase-create-users.js
   ```

#### Option C: Use Supabase SQL Editor

1. Go to SQL Editor in your Supabase project
2. First, create the users in auth (you'll need to use the Dashboard for this)
3. Then run this SQL to create the user profiles:

```sql
-- After creating auth users, get their IDs and run:
INSERT INTO public.users (id, email, firstName, lastName, role, isActive) VALUES
  ('auth-user-id-1', 'admin@osoul.com', 'Admin', 'User', 'admin', true),
  ('auth-user-id-2', 'manager@osoul.com', 'Manager', 'User', 'manager', true),
  ('auth-user-id-3', 'collector1@osoul.com', 'Collector', 'One', 'collector', true),
  ('auth-user-id-4', 'viewer@osoul.com', 'Viewer', 'User', 'viewer', true)
ON CONFLICT (email) DO UPDATE SET
  firstName = EXCLUDED.firstName,
  lastName = EXCLUDED.lastName,
  role = EXCLUDED.role,
  isActive = EXCLUDED.isActive;
```

### 3. Updated Login Logic ✅

Fixed the login component to properly handle the authentication response.

## Verification Steps

1. **Clear your browser cache and reload the page**
2. **Check that Ethereum provider errors are gone** - You should only see one provider being set
3. **Try logging in** with one of the demo credentials after creating the users

## Additional Notes

- The Ethereum provider conflicts are caused by multiple browser extensions (MetaMask, Coinbase Wallet, etc.)
- The solution allows the first provider to be set and ignores subsequent attempts
- Make sure your Supabase project has the proper tables created (users, accounts, collections, etc.)
- If you still see authentication errors, check that:
  - The Supabase URL and anon key in your environment are correct
  - The users table exists in your Supabase database
  - RLS (Row Level Security) policies allow user creation/access

## Environment Configuration

Make sure you have the correct environment variables:

```env
VITE_SUPABASE_URL=https://mrecphuxcweignmdytal.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY
```

## Quick Test

After implementing the fixes:

1. Open the browser console
2. Reload the page
3. You should see:
   - "Setting ethereum provider: MetaMask" (or similar) only once
   - No "Cannot redefine property: ethereum" errors
   - No "Cannot set property ethereum" errors
4. Try logging in with: admin@osoul.com / password123