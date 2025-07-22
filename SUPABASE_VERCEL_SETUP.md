# Supabase + Vercel Setup Guide

This guide will help you set up the Osoul Collection Reporting System using Supabase as your database and Vercel for deployment.

## Prerequisites

1. A Supabase account (https://supabase.com)
2. A Vercel account (https://vercel.com)
3. Node.js 18+ installed locally

## Step 1: Set up Supabase

### 1.1 Create a Supabase Project

1. Go to https://supabase.com and create a new project
2. Choose a name, database password, and region
3. Wait for the project to be created

### 1.2 Get Your Supabase Credentials

1. Go to Settings → API in your Supabase dashboard
2. Copy the following:
   - Project URL (e.g., `https://xxxxxxxxxxxxx.supabase.co`)
   - Anon/Public Key
   - Service Role Key (keep this secret!)

### 1.3 Set up the Database Schema

1. Go to SQL Editor in Supabase
2. Create a new query and paste the contents of `supabase-collection-schema.sql`
3. Run the query to create all tables

### 1.4 Insert Demo Users

1. In SQL Editor, create another query
2. Run this SQL to create the demo users:

```sql
-- Create demo users with hashed passwords
INSERT INTO users (email, password, first_name, last_name, role) VALUES
('admin@osoul.com', crypt('password123', gen_salt('bf')), 'Admin', 'User', 'admin'),
('manager@osoul.com', crypt('password123', gen_salt('bf')), 'Manager', 'User', 'manager'),
('collector1@osoul.com', crypt('password123', gen_salt('bf')), 'Ahmed', 'Ali', 'collector'),
('viewer@osoul.com', crypt('password123', gen_salt('bf')), 'Viewer', 'User', 'viewer');
```

## Step 2: Configure the Backend for Supabase

### 2.1 Update Backend Environment Variables

Create a `.env` file in the `backend` directory:

```env
# Supabase Configuration
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@[YOUR-PROJECT].supabase.co:5432/postgres
SUPABASE_URL=https://[YOUR-PROJECT].supabase.co
SUPABASE_SERVICE_KEY=your-service-role-key

# Server Configuration
PORT=5000
NODE_ENV=production

# JWT Configuration
JWT_SECRET=your-secure-jwt-secret
JWT_EXPIRE=7d

# API Configuration
API_VERSION=v1
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX=100

# Frontend URL (update for production)
FRONTEND_URL=https://your-app.vercel.app
```

### 2.2 Update Database Connection

The backend should already be configured to use the `DATABASE_URL` environment variable.

## Step 3: Configure the Frontend

### 3.1 Update Frontend Environment Variables

Create a `.env` file in the root directory:

```env
# For local development
VITE_API_URL=http://localhost:5000/api/v1
VITE_SUPABASE_URL=https://[YOUR-PROJECT].supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key

# For production (Vercel)
# VITE_API_URL=https://your-backend.vercel.app/api/v1
```

## Step 4: Deploy Backend to Vercel

### 4.1 Prepare Backend for Vercel

1. Create `backend/vercel.json`:

```json
{
  "version": 2,
  "builds": [
    {
      "src": "src/server.js",
      "use": "@vercel/node"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "src/server.js"
    }
  ]
}
```

### 4.2 Deploy Backend

1. Install Vercel CLI: `npm i -g vercel`
2. In the `backend` directory, run: `vercel`
3. Follow the prompts to deploy
4. Add environment variables in Vercel dashboard

## Step 5: Deploy Frontend to Vercel

### 5.1 Update Frontend API URL

Before deploying, update the `.env` file with your backend URL:

```env
VITE_API_URL=https://your-backend.vercel.app/api/v1
```

### 5.2 Deploy Frontend

1. In the root directory, run: `vercel`
2. Follow the prompts
3. Add environment variables in Vercel dashboard

## Step 6: Configure CORS

Make sure your backend allows requests from your frontend domain:

1. Update `FRONTEND_URL` in backend environment variables
2. Redeploy backend

## Demo Users

After setup, you can login with:

- **Admin**: admin@osoul.com / password123
- **Manager**: manager@osoul.com / password123
- **Collector**: collector1@osoul.com / password123
- **Viewer**: viewer@osoul.com / password123

## Troubleshooting

### Login Issues

1. Check browser console for errors
2. Verify API URL is correct in frontend
3. Check CORS settings in backend
4. Verify users exist in Supabase database

### Database Connection Issues

1. Check DATABASE_URL format
2. Verify Supabase project is active
3. Check connection pooling settings

### Deployment Issues

1. Check Vercel build logs
2. Verify all environment variables are set
3. Check Node.js version compatibility