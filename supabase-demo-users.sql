-- This script creates demo users in Supabase
-- Run this in the Supabase SQL editor after creating the tables

-- Note: You need to create auth users first using Supabase Dashboard or Auth API
-- Then run these inserts to create the corresponding user profiles

-- After creating auth users with these emails in Supabase Dashboard:
-- admin@osoul.com (password: password123)
-- manager@osoul.com (password: password123)
-- collector1@osoul.com (password: password123)
-- viewer@osoul.com (password: password123)

-- Insert user profiles (replace the UUIDs with actual auth.users IDs from your Supabase project)
-- You can get the user IDs from the Authentication section in Supabase Dashboard

/*
Example: After creating users in Supabase Auth, run:

INSERT INTO public.users (id, email, firstName, lastName, role, isActive) VALUES
  ('YOUR-ADMIN-UUID', 'admin@osoul.com', 'Admin', 'User', 'admin', true),
  ('YOUR-MANAGER-UUID', 'manager@osoul.com', 'Manager', 'User', 'manager', true),
  ('YOUR-COLLECTOR-UUID', 'collector1@osoul.com', 'Collector', 'One', 'collector', true),
  ('YOUR-VIEWER-UUID', 'viewer@osoul.com', 'Viewer', 'User', 'viewer', true)
ON CONFLICT (email) DO UPDATE SET
  firstName = EXCLUDED.firstName,
  lastName = EXCLUDED.lastName,
  role = EXCLUDED.role,
  isActive = EXCLUDED.isActive;
*/

-- Alternative: Create a function to automatically create user profiles when auth users are created
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.users (id, email, firstName, lastName, role)
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'firstName', split_part(new.email, '@', 1)),
    COALESCE(new.raw_user_meta_data->>'lastName', ''),
    COALESCE(new.raw_user_meta_data->>'role', 'viewer')
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger for auto-creating user profiles
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Insert sample data for testing
-- Sample accounts
INSERT INTO public.accounts (accountNumber, customerName, customerPhone, productType, outstandingAmount, daysPastDue, status, branchId) 
SELECT 
  'ACC-' || LPAD(generate_series::text, 6, '0'),
  'Customer ' || generate_series,
  '+966' || (500000000 + generate_series)::text,
  CASE (generate_series % 5)
    WHEN 0 THEN 'Auto Finance'
    WHEN 1 THEN 'Personal Finance'
    WHEN 2 THEN 'Home Finance'
    WHEN 3 THEN 'SME Finance'
    ELSE 'Credit Card'
  END,
  (RANDOM() * 100000 + 10000)::numeric(15,2),
  (RANDOM() * 180)::integer,
  'active',
  (SELECT id FROM public.branches ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1, 100)
ON CONFLICT (accountNumber) DO NOTHING;

-- Sample collections (last 30 days)
INSERT INTO public.collections (accountId, amount, collectionDate, paymentMethod, referenceNumber, branchId)
SELECT 
  (SELECT id FROM public.accounts ORDER BY RANDOM() LIMIT 1),
  (RANDOM() * 10000 + 1000)::numeric(15,2),
  CURRENT_DATE - (RANDOM() * 30)::integer,
  CASE (RANDOM() * 4)::integer
    WHEN 0 THEN 'Cash'
    WHEN 1 THEN 'Bank Transfer'
    WHEN 2 THEN 'Check'
    ELSE 'Online Payment'
  END,
  'REF-' || LPAD(generate_series::text, 8, '0'),
  (SELECT id FROM public.branches ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1, 200)
ON CONFLICT DO NOTHING;

-- Sample promises to pay
INSERT INTO public.promises_to_pay (accountId, promiseDate, promisedAmount, status, branchId)
SELECT 
  (SELECT id FROM public.accounts ORDER BY RANDOM() LIMIT 1),
  CURRENT_DATE + (RANDOM() * 30)::integer,
  (RANDOM() * 5000 + 1000)::numeric(15,2),
  CASE (RANDOM() * 3)::integer
    WHEN 0 THEN 'pending'
    WHEN 1 THEN 'kept'
    ELSE 'broken'
  END,
  (SELECT id FROM public.branches ORDER BY RANDOM() LIMIT 1)
FROM generate_series(1, 50)
ON CONFLICT DO NOTHING;