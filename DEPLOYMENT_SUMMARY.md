# Quick Fix for Vercel Deployment Error

## The Problem
Your frontend on Vercel is trying to connect to `localhost:5000` which doesn't exist in production.

## The Solution

### Step 1: Deploy Your Backend
Choose one of these platforms:
- **Render** (Free tier): Use the `backend/render.yaml` file I created
- **Railway**: Simple GitHub integration
- **Heroku**: Requires payment

### Step 2: Set Environment Variables in Vercel
1. Go to your Vercel project → Settings → Environment Variables
2. Add: `VITE_API_URL = https://your-backend-url.com/api/v1`

### Step 3: Set Backend Environment Variables
On your backend hosting platform, set:
```
DATABASE_URL=your-database-connection-string
JWT_SECRET=your-secret-key
FRONTEND_URL=https://your-vercel-app.vercel.app
```

### Step 4: Redeploy
Redeploy both frontend (Vercel) and backend.

## Files Created/Updated
- `.env.example` - Frontend environment example
- `.gitignore` - To exclude sensitive files
- `backend/.env.example` - Backend environment example
- `backend/render.yaml` - Render deployment config
- `DEPLOYMENT_FIX.md` - Detailed guide

## Next Steps
1. Deploy your backend first
2. Get the backend URL
3. Update Vercel environment variable
4. Redeploy on Vercel

That's it! Your app should work after these steps.