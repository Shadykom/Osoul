-- =============================================
-- Initialize Demo Users for Supabase
-- =============================================

-- First, ensure the pgcrypto extension is enabled for password hashing
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Check if users table exists from the schema
-- If not, you need to run supabase-collection-schema.sql first

-- Delete existing demo users if they exist
DELETE FROM users WHERE email IN (
  'admin@osoul.com',
  'manager@osoul.com',
  'collector1@osoul.com',
  'collector2@osoul.com',
  'viewer@osoul.com'
);

-- Insert demo users with bcrypt hashed passwords
-- Password for all users: password123
INSERT INTO users (email, password, first_name, last_name, role, is_active) VALUES
  ('admin@osoul.com', crypt('password123', gen_salt('bf')), 'Admin', 'User', 'admin', true),
  ('manager@osoul.com', crypt('password123', gen_salt('bf')), 'Manager', 'User', 'manager', true),
  ('collector1@osoul.com', crypt('password123', gen_salt('bf')), 'Ahmed', 'Ali', 'collector', true),
  ('collector2@osoul.com', crypt('password123', gen_salt('bf')), 'Mohammed', 'Hassan', 'collector', true),
  ('viewer@osoul.com', crypt('password123', gen_salt('bf')), 'Viewer', 'User', 'viewer', true);

-- Create sample branches if they don't exist
INSERT INTO branches (branch_code, branch_name, region, city, manager_id) 
SELECT 'BR001', 'Riyadh Main Branch', 'Central', 'Riyadh', u.id
FROM users u 
WHERE u.email = 'manager@osoul.com'
ON CONFLICT (branch_code) DO NOTHING;

INSERT INTO branches (branch_code, branch_name, region, city, manager_id) 
SELECT 'BR002', 'Jeddah Branch', 'Western', 'Jeddah', u.id
FROM users u 
WHERE u.email = 'manager@osoul.com'
ON CONFLICT (branch_code) DO NOTHING;

INSERT INTO branches (branch_code, branch_name, region, city, manager_id) 
SELECT 'BR003', 'Dammam Branch', 'Eastern', 'Dammam', u.id
FROM users u 
WHERE u.email = 'manager@osoul.com'
ON CONFLICT (branch_code) DO NOTHING;

-- Verify users were created
SELECT email, first_name, last_name, role, is_active 
FROM users 
WHERE email IN (
  'admin@osoul.com',
  'manager@osoul.com',
  'collector1@osoul.com',
  'collector2@osoul.com',
  'viewer@osoul.com'
)
ORDER BY role, email;