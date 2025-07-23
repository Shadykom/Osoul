-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create users table (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  firstName TEXT,
  lastName TEXT,
  role TEXT CHECK (role IN ('admin', 'manager', 'collector', 'viewer')) DEFAULT 'viewer',
  isActive BOOLEAN DEFAULT true,
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updatedAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create branches table
CREATE TABLE IF NOT EXISTS public.branches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  code TEXT UNIQUE NOT NULL,
  location TEXT,
  isActive BOOLEAN DEFAULT true,
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create accounts table
CREATE TABLE IF NOT EXISTS public.accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  accountNumber TEXT UNIQUE NOT NULL,
  customerName TEXT NOT NULL,
  customerPhone TEXT,
  productType TEXT,
  outstandingAmount DECIMAL(15, 2) DEFAULT 0,
  daysPastDue INTEGER DEFAULT 0,
  status TEXT CHECK (status IN ('active', 'closed', 'written_off')) DEFAULT 'active',
  branchId UUID REFERENCES branches(id),
  assignedTo UUID REFERENCES users(id),
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updatedAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create collections table
CREATE TABLE IF NOT EXISTS public.collections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  accountId UUID REFERENCES accounts(id),
  amount DECIMAL(15, 2) NOT NULL,
  collectionDate DATE NOT NULL,
  collectorId UUID REFERENCES users(id),
  branchId UUID REFERENCES branches(id),
  paymentMethod TEXT,
  referenceNumber TEXT,
  notes TEXT,
  target DECIMAL(15, 2) DEFAULT 0,
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create promises_to_pay table
CREATE TABLE IF NOT EXISTS public.promises_to_pay (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  accountId UUID REFERENCES accounts(id),
  promiseDate DATE NOT NULL,
  promisedAmount DECIMAL(15, 2) NOT NULL,
  status TEXT CHECK (status IN ('pending', 'kept', 'broken')) DEFAULT 'pending',
  collectorId UUID REFERENCES users(id),
  branchId UUID REFERENCES branches(id),
  notes TEXT,
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updatedAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create contacts table
CREATE TABLE IF NOT EXISTS public.contacts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  accountId UUID REFERENCES accounts(id),
  contactDate TIMESTAMP WITH TIME ZONE NOT NULL,
  contactType TEXT CHECK (contactType IN ('phone', 'sms', 'email', 'visit', 'whatsapp')),
  outcome TEXT,
  notes TEXT,
  collectorId UUID REFERENCES users(id),
  createdAt TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_accounts_branch ON accounts(branchId);
CREATE INDEX IF NOT EXISTS idx_accounts_assigned ON accounts(assignedTo);
CREATE INDEX IF NOT EXISTS idx_accounts_dpd ON accounts(daysPastDue);
CREATE INDEX IF NOT EXISTS idx_collections_date ON collections(collectionDate);
CREATE INDEX IF NOT EXISTS idx_collections_branch ON collections(branchId);
CREATE INDEX IF NOT EXISTS idx_collections_collector ON collections(collectorId);
CREATE INDEX IF NOT EXISTS idx_ptp_status ON promises_to_pay(status);
CREATE INDEX IF NOT EXISTS idx_contacts_account ON contacts(accountId);

-- Create RLS policies
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.branches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.collections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.promises_to_pay ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;

-- Users table policies
CREATE POLICY "Users can view their own profile" ON public.users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Admins can view all users" ON public.users
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.users
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Branches table policies (everyone can read)
CREATE POLICY "All authenticated users can view branches" ON public.branches
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- Accounts table policies
CREATE POLICY "Users can view accounts" ON public.accounts
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      assignedTo = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager', 'viewer')
      )
    )
  );

-- Collections table policies
CREATE POLICY "Users can view collections" ON public.collections
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager', 'viewer')
      )
    )
  );

CREATE POLICY "Collectors can insert collections" ON public.collections
  FOR INSERT WITH CHECK (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager')
      )
    )
  );

-- PTP table policies
CREATE POLICY "Users can view PTPs" ON public.promises_to_pay
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager', 'viewer')
      )
    )
  );

CREATE POLICY "Collectors can manage PTPs" ON public.promises_to_pay
  FOR ALL USING (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager')
      )
    )
  );

-- Contacts table policies
CREATE POLICY "Users can view contacts" ON public.contacts
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager', 'viewer')
      )
    )
  );

CREATE POLICY "Collectors can insert contacts" ON public.contacts
  FOR INSERT WITH CHECK (
    auth.uid() IS NOT NULL AND (
      collectorId = auth.uid() OR
      EXISTS (
        SELECT 1 FROM public.users
        WHERE id = auth.uid() AND role IN ('admin', 'manager')
      )
    )
  );

-- Insert sample branches
INSERT INTO public.branches (name, code, location) VALUES
  ('Riyadh Branch', 'RYD', 'Riyadh, Saudi Arabia'),
  ('Jeddah Branch', 'JED', 'Jeddah, Saudi Arabia'),
  ('Dammam Branch', 'DMM', 'Dammam, Saudi Arabia')
ON CONFLICT (code) DO NOTHING;

-- Create function to automatically update updatedAt timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updatedAt = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updatedAt
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_accounts_updated_at BEFORE UPDATE ON public.accounts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_promises_to_pay_updated_at BEFORE UPDATE ON public.promises_to_pay
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();