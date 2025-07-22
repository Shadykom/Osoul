# Railway + Vercel Deployment Checklist

## ✅ Pre-Deployment Checklist

- [ ] Database is ready (PostgreSQL URL available)
- [ ] Your code is pushed to GitHub
- [ ] You have accounts on Railway and Vercel

## ✅ Railway Backend Deployment

1. [ ] Go to [Railway.app](https://railway.app)
2. [ ] Create New Project → Deploy from GitHub
3. [ ] Select your repository
4. [ ] Wait for initial deployment
5. [ ] Add environment variables:
   ```
   NODE_ENV=production
   PORT=5000
   DATABASE_URL=[your-database-url]
   JWT_SECRET=[generate-a-secure-key]
   JWT_EXPIRE=7d
   FRONTEND_URL=https://[your-app].vercel.app
   ```
6. [ ] Copy your Railway URL (e.g., `https://your-app.up.railway.app`)

## ✅ Vercel Frontend Configuration

1. [ ] Go to Vercel Dashboard → Your Project → Settings → Environment Variables
2. [ ] Add ONE variable:
   ```
   Name: VITE_API_URL
   Value: https://[your-railway-url].up.railway.app/api/v1
   ```
3. [ ] Click "Save"
4. [ ] Go to Deployments → Redeploy

## ✅ Post-Deployment Verification

1. [ ] Test backend health: 
   ```bash
   curl https://[your-railway-url].up.railway.app/health
   ```
   Should return: `{"status":"OK","timestamp":"..."}`

2. [ ] Check frontend: Visit your Vercel URL and try to login

## ⚠️ Common Issues

- **CORS Error**: Make sure `FRONTEND_URL` in Railway matches your Vercel URL exactly
- **Connection Refused**: Ensure `VITE_API_URL` has the correct Railway URL with `/api/v1`
- **401 Unauthorized**: Check that `JWT_SECRET` is set in Railway
- **Database Error**: Verify `DATABASE_URL` is correct and database is accessible

## 🎉 Success Indicators

- Backend health check returns OK
- No console errors in browser
- Login form submits without connection errors
- API calls show correct Railway URL in Network tab (not localhost)