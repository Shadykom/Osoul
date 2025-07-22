# Railway Backend + Vercel Frontend Setup

## 1. Deploy Backend on Railway

### Quick Steps:
1. Go to [Railway](https://railway.app)
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your repository
4. Railway will auto-detect it's a Node.js app
5. Click on your service → Variables tab
6. Add these environment variables:

```bash
# Required Environment Variables for Backend on Railway
NODE_ENV=production
PORT=5000
DATABASE_URL=postgresql://[get-from-your-database-provider]
JWT_SECRET=your-super-secret-jwt-key-here-make-it-long
JWT_EXPIRE=7d
FRONTEND_URL=https://your-app-name.vercel.app
```

### Railway will provide you with:
- A deployment URL like: `https://your-app-name.up.railway.app`

## 2. Vercel Environment Variables

Once your Railway backend is deployed, add this to Vercel:

### Go to Vercel Dashboard → Your Project → Settings → Environment Variables

Add this variable:

```bash
VITE_API_URL=https://your-app-name.up.railway.app/api/v1
```

### Example (replace with your actual Railway URL):
```bash
VITE_API_URL=https://osoul-backend.up.railway.app/api/v1
```

## 3. Complete Environment Variables List

### For Vercel (Frontend):
```bash
# This is the ONLY environment variable you need in Vercel
VITE_API_URL=https://your-railway-app.up.railway.app/api/v1
```

### For Railway (Backend):
```bash
NODE_ENV=production
PORT=5000
DATABASE_URL=postgresql://username:password@host:port/database_name
JWT_SECRET=generate-a-long-random-string-here
JWT_EXPIRE=7d
FRONTEND_URL=https://your-vercel-app.vercel.app
```

## 4. Database Setup

If you need a PostgreSQL database, you can:
- Use Railway's PostgreSQL add-on (click "New" → "Database" → "PostgreSQL")
- Use Supabase (free tier available)
- Use Neon (free tier available)

## 5. After Setting Variables

1. **On Railway**: Your backend will automatically redeploy
2. **On Vercel**: Click "Redeploy" → "Redeploy with existing Build Cache"

## Important Notes

- Make sure the `FRONTEND_URL` in Railway matches your Vercel app URL
- The `VITE_API_URL` must end with `/api/v1`
- Don't include trailing slashes in URLs
- Railway provides HTTPS by default, so use `https://` not `http://`

## Testing

After deployment, test your login endpoint:
```bash
curl https://your-railway-app.up.railway.app/api/v1/health
```

Should return a success response.