# Quick Fix: Make Backend Work with Supabase

If you want to use your existing backend with Supabase without major changes, here's a quick solution:

## Option 1: Update the Login Query (Recommended)

Edit `backend/src/routes/auth.routes.js` and modify the login route to support both bcrypt and Supabase's crypt:

```javascript
// Around line 88-104, replace the existing query and password check with:

// Try Supabase crypt first, then fall back to bcrypt
const result = await pool.query(
  `SELECT * FROM users 
   WHERE email = $1 
   AND is_active = true
   AND (
     password = crypt($2, password) OR  -- Supabase style
     password = $3                      -- For bcrypt comparison
   )`,
  [email, password, 'dummy'] // dummy value for now
);

if (result.rows.length === 0) {
  // If no match with crypt, try bcrypt
  const userResult = await pool.query(
    'SELECT * FROM users WHERE email = $1 AND is_active = true',
    [email]
  );
  
  if (userResult.rows.length === 0) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  const user = userResult.rows[0];
  
  // Verify with bcrypt
  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }
  
  // Continue with the user object...
} else {
  const user = result.rows[0];
  // Continue with token generation...
}
```

## Option 2: Use Different Endpoints

1. Keep the existing auth routes for local development
2. Use the Supabase auth route for production

In `backend/src/server.js`, add:

```javascript
import authSupabaseRoutes from './routes/auth.supabase.routes.js';

// After the existing auth routes
if (process.env.USE_SUPABASE_AUTH === 'true') {
  app.use(`/api/${apiVersion}/auth-supabase`, authSupabaseRoutes);
}
```

Then in your frontend, conditionally use the right endpoint:

```javascript
const authEndpoint = import.meta.env.VITE_USE_SUPABASE_AUTH === 'true' 
  ? '/auth-supabase/login' 
  : '/auth/login';
```

## Option 3: Migrate Existing Users to Supabase

If you have existing users with bcrypt passwords, run this migration in Supabase:

```sql
-- Add a temporary column to track migration
ALTER TABLE users ADD COLUMN IF NOT EXISTS password_migrated BOOLEAN DEFAULT false;

-- You'll need to manually update each user's password when they log in
-- Or ask them to reset their passwords
```

## Quickest Solution for Demo

For the demo users, just run this in Supabase SQL Editor:

```sql
-- Enable pgcrypto
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Update demo users passwords to use crypt
UPDATE users 
SET password = crypt('password123', gen_salt('bf'))
WHERE email IN (
  'admin@osoul.com',
  'manager@osoul.com', 
  'collector1@osoul.com',
  'viewer@osoul.com'
);
```

This will make the demo users work with the existing backend code that expects bcrypt passwords.