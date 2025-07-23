# Authentication Fix Guide

## Overview
This guide helps you fix the "Invalid login credentials" error and set up authentication properly for the Osoul Collection System.

## Quick Fix Steps

### 1. Access the Setup Page
Navigate to: `http://localhost:5173/setup-users` (or your deployed URL + `/setup-users`)

This page provides:
- Automatic user creation
- Login testing
- Troubleshooting information

### 2. Click "Setup Demo Users"
This will create the following users:
- `admin@osoul.com` (password: `password123`) - Admin role
- `manager@osoul.com` (password: `password123`) - Manager role
- `collector1@osoul.com` (password: `password123`) - Collector role
- `viewer@osoul.com` (password: `password123`) - Viewer role

### 3. Test the Logins
Click "Test All Logins" to verify that all users can authenticate properly.

## Manual Setup (If Automatic Setup Fails)

### Option 1: Using Supabase Dashboard

1. Go to your [Supabase Dashboard](https://app.supabase.com)
2. Select your project
3. Navigate to **Authentication** → **Users**
4. Click **Add user** → **Create new user**
5. For each demo user:
   - Enter the email (e.g., `admin@osoul.com`)
   - Enter password: `password123`
   - Check "Auto Confirm Email"
   - Click "Create user"

### Option 2: Using SQL Editor

1. In Supabase Dashboard, go to **SQL Editor**
2. Run this function to create the trigger for auto-creating user profiles:

```sql
-- Create function to handle new user profiles
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.users (id, email, firstName, lastName, role, isActive)
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'firstName', split_part(new.email, '@', 1)),
    COALESCE(new.raw_user_meta_data->>'lastName', ''),
    COALESCE(new.raw_user_meta_data->>'role', 'viewer'),
    true
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    firstName = EXCLUDED.firstName,
    lastName = EXCLUDED.lastName,
    role = EXCLUDED.role;
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### Option 3: Using Node.js Script

1. Install dependencies:
```bash
npm install @supabase/supabase-js dotenv
```

2. Create `.env` file:
```env
SUPABASE_SERVICE_KEY=your-service-role-key
```

3. Run the creation script:
```bash
node supabase-create-users.js
```

## Troubleshooting

### Error: "Invalid login credentials"
**Causes:**
- User doesn't exist in Supabase Auth
- Wrong password
- Email not confirmed

**Solutions:**
1. Check if user exists in Supabase Dashboard → Authentication → Users
2. Reset password if needed
3. Ensure email is confirmed

### Error: "User exists but can't sign in"
**Causes:**
- Password was changed
- Account is locked

**Solutions:**
1. Reset password via Supabase Dashboard
2. Delete and recreate the user

### Error: "Cannot redefine property: ethereum"
**Cause:** Multiple browser extensions trying to inject Web3

**Solution:** This is a browser extension conflict (MetaMask, etc.) and doesn't affect the app functionality. You can safely ignore it.

### Database Connection Issues

1. **Check Supabase Status:**
   - Visit [Supabase Status](https://status.supabase.com)
   - Check if your project is paused (free tier pauses after 1 week of inactivity)

2. **Verify Environment Variables:**
   ```bash
   VITE_SUPABASE_URL=your-project-url
   VITE_SUPABASE_ANON_KEY=your-anon-key
   ```

3. **Test Connection:**
   Open browser console and run:
   ```javascript
   // This should be logged automatically
   console.log('Supabase URL:', import.meta.env.VITE_SUPABASE_URL);
   ```

## Security Considerations

1. **For Production:**
   - Change all default passwords
   - Enable Row Level Security (RLS)
   - Use environment variables for sensitive data
   - Enable 2FA for admin accounts

2. **Email Confirmation:**
   - For testing: Disable email confirmation
   - For production: Enable email confirmation

## Additional Resources

- [Supabase Auth Documentation](https://supabase.com/docs/guides/auth)
- [Supabase Dashboard](https://app.supabase.com)
- Project specific Supabase URL: `https://mrecphuxcweignmdytal.supabase.co`

## Contact Support

If you continue to experience issues:
1. Check the browser console for detailed error messages
2. Verify your Supabase project is active
3. Ensure your database tables are properly created
4. Check that Row Level Security policies allow access