# Supabase Setup Guide for Osoul Collection System

## Overview
This guide will help you set up your Supabase database and integrate it with the Osoul Collection Management System.

## Prerequisites
- Supabase account and project created
- Node.js and npm installed
- Access to Supabase dashboard

## Step 1: Database Setup

### 1.1 Create Tables
1. Go to your Supabase SQL Editor
2. Run the schema creation script:
   ```sql
   -- Copy and paste the contents of supabase-collection-schema.sql
   ```

### 1.2 Insert Sample Data
1. After tables are created, run the sample data script:
   ```sql
   -- Copy and paste the contents of supabase-collection-sample-data.sql
   ```

### 1.3 Verify Setup
Run these queries to verify data was inserted:
```sql
-- Check customers
SELECT COUNT(*) FROM customers;

-- Check finance accounts
SELECT COUNT(*) FROM finance_accounts;

-- Check collection cases
SELECT COUNT(*) FROM collection_cases;
```

## Step 2: Environment Configuration

### 2.1 Create .env file
```bash
cp .env.example .env
```

### 2.2 Update .env with your credentials
```env
VITE_SUPABASE_URL=https://mrecphuxcweignmdytal.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1yZWNwaHV4Y3dlaWdubWR5dGFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNjY2MjMsImV4cCI6MjA2ODc0MjYyM30.4I-S7pvJT4py5Ui5cJL08euMdoTWd3YxDF_-IJYqHeY
```

## Step 3: Update Frontend Components

### 3.1 Update CollectionDashboard.jsx
Replace the mock data imports with Supabase service:

```javascript
import { useEffect, useState } from 'react';
import { collectionDashboardService } from '@/services/supabaseCollectionService';

const CollectionDashboard = () => {
  const [summaryMetrics, setSummaryMetrics] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      const { data, error } = await collectionDashboardService.getSummaryMetrics();
      if (error) throw error;
      setSummaryMetrics(data);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
    } finally {
      setLoading(false);
    }
  };

  // Rest of component...
};
```

### 3.2 Update CollectionReports.jsx
Similar pattern for reports:

```javascript
import { collectionReportsService } from '@/services/supabaseCollectionService';

// In your component
const fetchDailyReport = async (date) => {
  const { data, error } = await collectionReportsService.getDailyCollection(date);
  if (error) {
    console.error('Error:', error);
    return;
  }
  setReportData(data);
};
```

## Step 4: Authentication Setup (Optional)

### 4.1 Enable Authentication in Supabase
1. Go to Authentication settings in Supabase
2. Enable Email/Password authentication
3. Configure email templates

### 4.2 Update Login Component
```javascript
import { supabase } from '@/lib/supabase';

const handleLogin = async (email, password) => {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password
  });
  
  if (error) {
    console.error('Login error:', error);
    return;
  }
  
  // Store user session
  localStorage.setItem('user', JSON.stringify(data.user));
};
```

## Step 5: Row Level Security (RLS)

### 5.1 Enable RLS for sensitive tables
```sql
-- Enable RLS
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE finance_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE collection_cases ENABLE ROW LEVEL SECURITY;

-- Create policies for authenticated users
CREATE POLICY "Authenticated users can view all data" ON customers
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Collectors can view their assigned cases" ON collection_cases
  FOR SELECT TO authenticated 
  USING (assigned_collector_id = auth.uid());
```

## Step 6: Real-time Subscriptions (Optional)

### 6.1 Subscribe to collection activities
```javascript
import { supabase } from '@/lib/supabase';

// Subscribe to new collection activities
const subscription = supabase
  .channel('collection-activities')
  .on('postgres_changes', 
    { 
      event: 'INSERT', 
      schema: 'public', 
      table: 'collection_activities' 
    }, 
    (payload) => {
      console.log('New activity:', payload.new);
      // Update UI with new activity
    }
  )
  .subscribe();

// Don't forget to unsubscribe when component unmounts
return () => {
  subscription.unsubscribe();
};
```

## Step 7: Performance Optimization

### 7.1 Create Additional Indexes
```sql
-- Add composite indexes for common queries
CREATE INDEX idx_accounts_status_bucket ON finance_accounts(account_status, bucket);
CREATE INDEX idx_activities_account_date ON collection_activities(account_id, activity_datetime);
CREATE INDEX idx_ptp_status_date ON promise_to_pay(ptp_status, promise_date);
```

### 7.2 Use Supabase Edge Functions for Complex Logic
Create edge functions for complex calculations:

```typescript
// supabase/functions/calculate-collection-metrics/index.ts
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  )

  // Complex calculation logic here
  
  return new Response(
    JSON.stringify({ data: metrics }),
    { headers: { 'Content-Type': 'application/json' } }
  )
})
```

## Step 8: Monitoring and Maintenance

### 8.1 Monitor Database Performance
- Use Supabase Dashboard to monitor query performance
- Set up alerts for slow queries
- Monitor storage usage

### 8.2 Regular Maintenance Tasks
```sql
-- Update PTP statuses daily
SELECT update_ptp_status();

-- Refresh materialized views (if created)
REFRESH MATERIALIZED VIEW mv_collection_summary;
```

## Troubleshooting

### Common Issues

1. **CORS Errors**
   - Check Supabase URL is correct
   - Ensure anon key is valid

2. **Permission Denied**
   - Check RLS policies
   - Verify user authentication

3. **Slow Queries**
   - Add appropriate indexes
   - Use query explain plan
   - Consider pagination

### Debug Mode
Enable debug logging:
```javascript
// In development
if (process.env.NODE_ENV === 'development') {
  supabase.auth.onAuthStateChange((event, session) => {
    console.log('Auth event:', event, session);
  });
}
```

## Next Steps

1. **Implement Authentication**: Set up proper user authentication
2. **Add File Storage**: Use Supabase Storage for documents
3. **Set Up Webhooks**: Integrate with external systems
4. **Configure Backups**: Enable point-in-time recovery
5. **Add API Rate Limiting**: Protect your endpoints

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase JavaScript Client](https://supabase.com/docs/reference/javascript/introduction)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)