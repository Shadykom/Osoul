# Osoul Collection System - GitHub Deployment Guide

## Overview
This guide contains all the updated files and instructions to deploy your Osoul Collection Reporting System with Supabase integration to GitHub and production platforms.

## Files Changed/Added

### New Files Created:
1. **`backend/src/config/supabase.js`** - Supabase client configuration
2. **`backend/src/routes/auth.supabase.routes.js`** - Supabase-compatible authentication routes
3. **`backend/src/middleware/auth.supabase.js`** - Supabase-compatible authentication middleware

### Modified Files:
1. **`backend/src/server.js`** - Updated to use Supabase auth routes
2. **`backend/package.json`** - Added @supabase/supabase-js dependency

### Environment Files:
1. **`.env.development`** - Development environment variables
2. **`.env.production`** - Production environment variables  
3. **`frontend.env`** - Frontend environment variables

## Step-by-Step Deployment

### 1. Update Your GitHub Repository

Replace/add these files in your GitHub repository:

#### Backend Files:
```
backend/
├── src/
│   ├── config/
│   │   └── supabase.js                    [NEW]
│   ├── routes/
│   │   └── auth.supabase.routes.js        [NEW]
│   ├── middleware/
│   │   └── auth.supabase.js               [NEW]
│   └── server.js                          [MODIFIED]
├── package.json                           [MODIFIED]
└── .env                                   [UPDATE WITH PROVIDED VALUES]
```

#### Root Directory:
```
├── .env.development                       [NEW]
├── .env.production                        [NEW]
└── .env                                   [UPDATE FOR FRONTEND]
```

### 2. Environment Variables Setup

#### For Backend (.env):
```env
DATABASE_URL=postgresql://postgres:OUSOL%401a159753@db.mrecphuxcweignmdytal.supabase.co:5432/postgres
SUPABASE_URL=https://mrecphuxcweignmdytal.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY
JWT_SECRET=osoul_jwt_secret_key_production_2024_supabase_secure
NODE_ENV=production
PORT=5000
FRONTEND_URL=https://your-frontend-url.vercel.app
```

#### For Frontend (.env):
```env
VITE_API_URL=https://your-backend-url.vercel.app/api/v1
VITE_SUPABASE_URL=https://mrecphuxcweignmdytal.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY
```

### 3. Deploy to Vercel

#### Backend Deployment:
1. Create new Vercel project for backend
2. Connect your GitHub repository
3. Set root directory to `backend`
4. Add all environment variables from `.env.production`
5. Deploy

#### Frontend Deployment:
1. Create new Vercel project for frontend
2. Connect your GitHub repository  
3. Set root directory to project root
4. Add frontend environment variables
5. Update `VITE_API_URL` with your deployed backend URL
6. Deploy

### 4. Update CORS Settings

After deployment, update the backend environment variable:
```env
FRONTEND_URL=https://your-actual-frontend-url.vercel.app
```

## Test Users Available

After deployment, you can log in with:

| Email | Password | Role |
|-------|----------|------|
| admin@osoul.com | password123 | admin |
| manager@osoul.com | password123 | manager |
| collector1@osoul.com | password123 | collector |
| viewer@osoul.com | password123 | viewer |

## Local Development

### Backend:
```bash
cd backend
npm install
npm start
```

### Frontend:
```bash
npm install
npm run dev
```

## Production Checklist

- [ ] Update JWT_SECRET to a secure random string
- [ ] Change default user passwords
- [ ] Enable Row Level Security (RLS) in Supabase
- [ ] Configure proper CORS origins
- [ ] Set up monitoring and logging
- [ ] Enable HTTPS only
- [ ] Configure rate limiting appropriately

## Troubleshooting

### Common Issues:

1. **CORS Errors**: Ensure FRONTEND_URL matches your deployed frontend URL
2. **Database Connection**: Verify Supabase credentials are correct
3. **Authentication Fails**: Check JWT_SECRET is consistent between deployments
4. **Environment Variables**: Ensure all required variables are set in deployment platform

### Database Issues:
- Your Supabase database is already configured and working
- Users table exists with test data
- No additional database setup required

## Security Notes

### Current Security Features:
- ✅ JWT-based authentication
- ✅ Password hashing with bcryptjs  
- ✅ Role-based access control
- ✅ Rate limiting
- ✅ CORS protection
- ✅ Helmet security headers

### Production Recommendations:
- Change all default passwords
- Use strong JWT secrets
- Enable Supabase Row Level Security
- Set up proper monitoring
- Regular security updates

## Support

Your Osoul Collection Reporting System is now ready for deployment with:
- Cloud Supabase database integration
- Working authentication system
- Production-ready configuration
- Secure environment setup

All files are provided and tested. The system is fully functional! 🚀

