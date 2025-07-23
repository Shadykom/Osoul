# Supabase Integration Guide

This project has been integrated directly with Supabase, eliminating the need for a separate backend server. All authentication and data operations are now handled directly through Supabase.

## What's Changed

### 1. **Direct Supabase Integration**
- Removed dependency on the backend API server
- All data operations now use Supabase client directly
- Authentication is handled by Supabase Auth

### 2. **New Services**
- `src/services/supabaseAuth.js` - Handles authentication with Supabase
- `src/services/supabaseDashboard.js` - Fetches dashboard data directly from Supabase
- `src/lib/supabase.js` - Supabase client configuration

### 3. **Updated Authentication**
- Login now uses Supabase Auth
- User sessions are managed by Supabase
- Role-based access control through Supabase RLS policies

## Setup Instructions

### 1. **Configure Environment Variables**
Create a `.env` file in the root directory with your Supabase credentials:

```env
VITE_SUPABASE_URL=your-supabase-project-url
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
```

### 2. **Set Up Supabase Database**

1. Go to your Supabase project dashboard
2. Navigate to the SQL Editor
3. Run the migration script `supabase-migration.sql` to create all necessary tables and policies
4. Run the demo users script `supabase-demo-users.sql` to set up sample data

### 3. **Create Demo Users**

In Supabase Dashboard:
1. Go to Authentication → Users
2. Create the following users:
   - Email: `admin@osoul.com`, Password: `password123`
   - Email: `manager@osoul.com`, Password: `password123`
   - Email: `collector1@osoul.com`, Password: `password123`
   - Email: `viewer@osoul.com`, Password: `password123`

3. After creating auth users, update the user profiles in the database with their roles

### 4. **Run the Application**

```bash
npm install
npm run dev
```

## Features

### Authentication
- Secure login with Supabase Auth
- Session management
- Role-based access control (Admin, Manager, Collector, Viewer)

### Dashboard
- Real-time data fetching from Supabase
- Summary metrics
- Collection trends
- Aging buckets analysis
- Collector performance tracking
- Product-wise NPF analysis

### Security
- Row Level Security (RLS) policies enforce data access rules
- Users can only see data they're authorized to access
- Secure API calls with Supabase auth tokens

## Database Schema

### Tables
- `users` - User profiles with roles
- `branches` - Company branches
- `accounts` - Customer accounts
- `collections` - Payment collections
- `promises_to_pay` - PTP records
- `contacts` - Customer contact history

### Row Level Security
- Admins can access all data
- Managers can view all data and manage collections
- Collectors can view and manage their assigned accounts
- Viewers have read-only access to reports

## Troubleshooting

### Login Issues
1. Verify Supabase URL and anon key in `.env`
2. Check if users are created in Supabase Auth
3. Ensure user profiles exist in the `users` table with correct roles

### Data Not Loading
1. Check browser console for errors
2. Verify RLS policies are correctly set up
3. Ensure tables have sample data

### Dashboard Empty
1. Run the sample data insertion from `supabase-demo-users.sql`
2. Check if the logged-in user has appropriate permissions
3. Verify date filters are set correctly

## Benefits of Direct Supabase Integration

1. **Simplified Architecture** - No need to maintain a separate backend
2. **Real-time Updates** - Supabase provides real-time subscriptions
3. **Better Security** - RLS policies at the database level
4. **Reduced Latency** - Direct database queries
5. **Cost Effective** - One less server to maintain
6. **Scalability** - Supabase handles scaling automatically

## Next Steps

1. Configure Supabase real-time subscriptions for live updates
2. Add more dashboard widgets
3. Implement advanced filtering options
4. Add data export functionality
5. Set up automated backups in Supabase