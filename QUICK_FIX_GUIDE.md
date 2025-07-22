# Quick Fix Guide for Login Issues

## Current Issues:
1. Frontend is trying to login at: `https://ousolbackend-production.up.railway.app/api/v1/auth/login`
2. Backend is running but has no database connection
3. Getting 404 errors because database queries are failing

## Immediate Fix Steps:

### 1. Set up Database on Railway

Go to your Railway project and add PostgreSQL:
- Click "New" → "Database" → "Add PostgreSQL"
- Connect it to your backend service

### 2. Add Environment Variables to Railway Backend

In your Railway backend service, add these variables:
```
DATABASE_URL=${{Postgres.DATABASE_URL}}
JWT_SECRET=your-secret-jwt-key-here
JWT_EXPIRE=7d
FRONTEND_URL=https://osoul-psi.vercel.app
PORT=5000
```

### 3. Run Database Migration

SSH into Railway or use Railway CLI:
```bash
# Install Railway CLI if not installed
npm install -g @railway/cli

# Login to Railway
railway login

# Link to your project
railway link

# Run the schema
railway run psql $DATABASE_URL < backend/database/schema.sql
```

### 4. Create a Test User (Optional)

```sql
INSERT INTO users (email, password, first_name, last_name, role) 
VALUES (
  'admin@osoul.com', 
  '$2a$10$YourHashedPasswordHere', 
  'Admin', 
  'User', 
  'admin'
);
```

### 5. Update Frontend (Already Done)

Your `.env` file already has the correct backend URL:
```
VITE_API_URL=https://ousolbackend-production.up.railway.app/api/v1
```

### 6. Rebuild and Deploy

For frontend (if using Vercel):
- Push changes to trigger rebuild
- Or manually redeploy from Vercel dashboard

## Testing

After setup, test the login:
```bash
curl -X POST https://ousolbackend-production.up.railway.app/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@osoul.com","password":"your-password"}'
```

## If Still Having Issues:

1. Check Railway logs for your backend
2. Verify DATABASE_URL is set correctly
3. Make sure PostgreSQL addon is running
4. Check CORS settings match your frontend URL