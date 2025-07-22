# Railway Database Setup Guide

## Setting up PostgreSQL on Railway

### 1. Add PostgreSQL to your Railway project

1. Go to your Railway project dashboard
2. Click "New" → "Database" → "Add PostgreSQL"
3. Railway will automatically provision a PostgreSQL database

### 2. Connect Database to Backend

1. In your Railway backend service, go to "Variables"
2. Click "Add Reference Variable"
3. Select your PostgreSQL database
4. Railway will automatically add these variables:
   - `DATABASE_URL` - Full connection string
   - `PGHOST` - Database host
   - `PGPORT` - Database port
   - `PGUSER` - Database user
   - `PGPASSWORD` - Database password
   - `PGDATABASE` - Database name

### 3. Update Backend Environment Variables

Make sure your backend service has these variables:
```
DATABASE_URL=${{Postgres.DATABASE_URL}}
JWT_SECRET=your-secret-key-here
JWT_EXPIRE=7d
FRONTEND_URL=https://osoul-psi.vercel.app
```

### 4. Initialize Database Schema

You'll need to run your database migrations. You can do this by:

1. Using Railway's CLI:
```bash
railway run npm run migrate
```

2. Or add a migration script to your `package.json`:
```json
{
  "scripts": {
    "migrate": "node src/migrations/init.js"
  }
}
```

### 5. Verify Connection

After setting up, your backend should be able to connect to the database and the login endpoint should work.

## Alternative: Use Supabase

If you prefer using Supabase (which provides both PostgreSQL and authentication):

1. Create a project at https://supabase.com
2. Get your database URL from Settings → Database
3. Add to Railway environment variables:
```
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@[YOUR-PROJECT].supabase.co:5432/postgres
```

## Troubleshooting

If you still get errors:
1. Check Railway logs: `railway logs`
2. Verify database is running in Railway dashboard
3. Test connection with: `railway run node -e "console.log(process.env.DATABASE_URL)"`