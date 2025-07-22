# Fixing the Vercel Deployment Error

The error `Failed to load resource: net::ERR_CONNECTION_REFUSED` at `localhost:5000/api/v1/auth/login` occurs because your frontend deployed on Vercel is trying to connect to a localhost backend that doesn't exist in production.

## Solution Steps

### 1. Deploy Your Backend

Your backend needs to be deployed separately. Here are some options:

#### Option A: Deploy on Render (Recommended - Free tier available)
1. Create an account on [Render](https://render.com)
2. Connect your GitHub repository
3. Create a new Web Service
4. Set the following:
   - Build Command: `cd backend && npm install`
   - Start Command: `cd backend && npm start`
   - Environment Variables (add these in Render dashboard):
     ```
     NODE_ENV=production
     PORT=5000
     JWT_SECRET=your-secret-key
     DATABASE_URL=your-database-url
     ```

#### Option B: Deploy on Railway
1. Create an account on [Railway](https://railway.app)
2. Connect your GitHub repository
3. Deploy the backend directory
4. Add the required environment variables

#### Option C: Deploy on Heroku (Paid only now)
1. Create a Heroku app
2. Deploy the backend directory
3. Add environment variables

### 2. Update Frontend Environment Variable on Vercel

Once your backend is deployed, you'll get a URL like:
- Render: `https://your-app.onrender.com`
- Railway: `https://your-app.up.railway.app`

1. Go to your Vercel project dashboard
2. Navigate to Settings → Environment Variables
3. Add the following variable:
   ```
   VITE_API_URL = https://your-backend-url.com/api/v1
   ```
   (Replace with your actual backend URL)

### 3. Redeploy on Vercel

After adding the environment variable:
1. Go to the Deployments tab in Vercel
2. Click on the three dots menu on your latest deployment
3. Select "Redeploy"

### 4. Verify the Fix

After redeployment, your frontend should connect to the production backend instead of localhost.

## Local Development

For local development, create a `.env` file in your project root:
```
VITE_API_URL=http://localhost:5000/api/v1
```

This file is already in `.gitignore` so it won't be committed to your repository.

## Backend Deployment Checklist

Before deploying the backend, ensure:
- [ ] Database is set up (PostgreSQL/Supabase)
- [ ] All environment variables are configured
- [ ] CORS is properly configured to allow your Vercel domain
- [ ] JWT_SECRET is set for authentication
- [ ] Database migrations are run

## CORS Configuration

Make sure your backend allows requests from your Vercel domain. In your backend, update the CORS configuration:

```javascript
app.use(cors({
  origin: [
    'http://localhost:5173',
    'https://your-app.vercel.app',
    'https://your-custom-domain.com'
  ],
  credentials: true
}));
```