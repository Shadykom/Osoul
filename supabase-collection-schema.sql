-- =============================================
-- Osoul Modern Company - Collection Department
-- Database Schema for Supabase (PostgreSQL)
-- Version: 1.0
-- Created: January 2025
-- =============================================

-- Enable UUID extension for better ID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- SECTION 1: CUSTOMER TABLES
-- =============================================

-- Customer Master Table
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    national_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name_ar VARCHAR(50),
    last_name_ar VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    nationality VARCHAR(50),
    employment_status VARCHAR(30),
    employer_name VARCHAR(100),
    monthly_income DECIMAL(15,2),
    credit_score INTEGER,
    risk_category VARCHAR(20),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Customer Contact Table
CREATE TABLE IF NOT EXISTS customer_contacts (
    contact_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE CASCADE,
    contact_type VARCHAR(20) CHECK (contact_type IN ('Mobile', 'Home', 'Work', 'Email', 'Address')),
    contact_value VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    is_valid BOOLEAN DEFAULT TRUE,
    verified_date DATE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 2: FINANCE ACCOUNT TABLES
-- =============================================

-- Finance Accounts Table
CREATE TABLE IF NOT EXISTS finance_accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    product_type VARCHAR(30) CHECK (product_type IN ('Auto Finance', 'Personal Finance', 'Home Finance', 'SME Finance', 'Credit Card')),
    finance_amount DECIMAL(15,2),
    profit_rate DECIMAL(5,2),
    tenure_months INTEGER,
    monthly_installment DECIMAL(15,2),
    outstanding_amount DECIMAL(15,2),
    principal_outstanding DECIMAL(15,2),
    profit_outstanding DECIMAL(15,2),
    origination_date DATE,
    maturity_date DATE,
    branch_code VARCHAR(10),
    officer_id VARCHAR(20),
    account_status VARCHAR(20),
    dpd INTEGER DEFAULT 0, -- Days Past Due
    bucket VARCHAR(20),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Payment Schedule Table
CREATE TABLE IF NOT EXISTS payment_schedule (
    schedule_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE CASCADE,
    installment_no INTEGER,
    due_date DATE,
    principal_amount DECIMAL(15,2),
    profit_amount DECIMAL(15,2),
    total_amount DECIMAL(15,2),
    paid_amount DECIMAL(15,2) DEFAULT 0,
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    dpd INTEGER DEFAULT 0
);

-- =============================================
-- SECTION 3: COLLECTION ACTIVITY TABLES
-- =============================================

-- Collectors Table
CREATE TABLE IF NOT EXISTS collectors (
    collector_id VARCHAR(20) PRIMARY KEY,
    employee_name VARCHAR(100),
    employee_name_ar VARCHAR(100),
    department VARCHAR(50),
    team_name VARCHAR(50),
    supervisor_id VARCHAR(20),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    collection_role VARCHAR(30),
    is_active BOOLEAN DEFAULT TRUE,
    join_date DATE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Collection Cases Table
CREATE TABLE IF NOT EXISTS collection_cases (
    case_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    assigned_collector_id VARCHAR(20) REFERENCES collectors(collector_id),
    assignment_date DATE,
    case_status VARCHAR(30),
    priority_level VARCHAR(20),
    total_outstanding DECIMAL(15,2),
    last_payment_date DATE,
    last_contact_date TIMESTAMP WITH TIME ZONE,
    next_action_date DATE,
    resolution_date DATE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Collection Activities Table
CREATE TABLE IF NOT EXISTS collection_activities (
    activity_id SERIAL PRIMARY KEY,
    case_id INTEGER REFERENCES collection_cases(case_id) ON DELETE CASCADE,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    collector_id VARCHAR(20) REFERENCES collectors(collector_id),
    activity_type VARCHAR(30) CHECK (activity_type IN ('Call', 'SMS', 'Email', 'Visit', 'Letter', 'Legal Notice')),
    activity_datetime TIMESTAMP WITH TIME ZONE,
    contact_person VARCHAR(100),
    contact_number VARCHAR(20),
    activity_result VARCHAR(50),
    promise_amount DECIMAL(15,2),
    promise_date DATE,
    notes TEXT,
    next_action VARCHAR(100),
    next_action_date DATE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Promise to Pay (PTP) Table
CREATE TABLE IF NOT EXISTS promise_to_pay (
    ptp_id SERIAL PRIMARY KEY,
    case_id INTEGER REFERENCES collection_cases(case_id) ON DELETE CASCADE,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    collector_id VARCHAR(20) REFERENCES collectors(collector_id),
    promise_amount DECIMAL(15,2),
    promise_date DATE,
    ptp_status VARCHAR(20) DEFAULT 'Active',
    actual_payment_amount DECIMAL(15,2),
    actual_payment_date DATE,
    kept_flag BOOLEAN DEFAULT FALSE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 4: PAYMENT & TRANSACTION TABLES
-- =============================================

-- Payment Transactions Table
CREATE TABLE IF NOT EXISTS payment_transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    payment_date DATE,
    payment_amount DECIMAL(15,2),
    payment_method VARCHAR(30),
    payment_channel VARCHAR(30),
    receipt_number VARCHAR(50),
    collected_by VARCHAR(20),
    allocation_type VARCHAR(30),
    principal_paid DECIMAL(15,2),
    profit_paid DECIMAL(15,2),
    late_fee_paid DECIMAL(15,2),
    transaction_status VARCHAR(20),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Settlements Table
CREATE TABLE IF NOT EXISTS settlements (
    settlement_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    original_outstanding DECIMAL(15,2),
    settlement_amount DECIMAL(15,2),
    discount_amount DECIMAL(15,2),
    discount_percentage DECIMAL(5,2),
    approval_level VARCHAR(30),
    approved_by VARCHAR(20),
    approval_date DATE,
    settlement_status VARCHAR(20),
    payment_plan VARCHAR(20),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 5: LEGAL & RECOVERY TABLES
-- =============================================

-- Legal Cases Table
CREATE TABLE IF NOT EXISTS legal_cases (
    legal_case_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    customer_id VARCHAR(20) REFERENCES customers(customer_id) ON DELETE RESTRICT,
    case_type VARCHAR(30),
    court_name VARCHAR(100),
    case_number VARCHAR(50),
    filing_date DATE,
    lawyer_name VARCHAR(100),
    case_status VARCHAR(30),
    judgment_date DATE,
    judgment_amount DECIMAL(15,2),
    legal_costs DECIMAL(15,2),
    next_hearing_date DATE,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Asset Recovery Table
CREATE TABLE IF NOT EXISTS asset_recovery (
    recovery_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    asset_type VARCHAR(30),
    asset_description VARCHAR(255),
    repossession_date DATE,
    storage_location VARCHAR(100),
    estimated_value DECIMAL(15,2),
    auction_date DATE,
    sale_amount DECIMAL(15,2),
    recovery_costs DECIMAL(15,2),
    net_recovery DECIMAL(15,2),
    recovery_status VARCHAR(30),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 6: PERFORMANCE TABLES
-- =============================================

-- Collector Performance Table
CREATE TABLE IF NOT EXISTS collector_performance (
    performance_id SERIAL PRIMARY KEY,
    collector_id VARCHAR(20) REFERENCES collectors(collector_id) ON DELETE CASCADE,
    performance_date DATE,
    assigned_cases INTEGER,
    contacted_cases INTEGER,
    collected_amount DECIMAL(15,2),
    target_amount DECIMAL(15,2),
    ptp_obtained INTEGER,
    ptp_kept INTEGER,
    calls_made INTEGER,
    visits_made INTEGER,
    success_rate DECIMAL(5,2),
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 7: SHARIA COMPLIANCE TABLES
-- =============================================

-- Sharia Compliance Table
CREATE TABLE IF NOT EXISTS sharia_compliance (
    compliance_id SERIAL PRIMARY KEY,
    account_id VARCHAR(20) REFERENCES finance_accounts(account_id) ON DELETE RESTRICT,
    compliance_type VARCHAR(50),
    late_payment_charges DECIMAL(15,2),
    charity_amount DECIMAL(15,2),
    charity_paid_date DATE,
    profit_purification DECIMAL(15,2),
    compliance_status VARCHAR(20),
    reviewed_by VARCHAR(50),
    review_date DATE,
    notes TEXT,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- SECTION 8: INDEXES FOR PERFORMANCE
-- =============================================

-- Customer indexes
CREATE INDEX idx_customer_national_id ON customers(national_id);
CREATE INDEX idx_customer_risk ON customers(risk_category);

-- Finance account indexes
CREATE INDEX idx_account_status_dpd ON finance_accounts(account_status, dpd);
CREATE INDEX idx_outstanding_amount ON finance_accounts(outstanding_amount);
CREATE INDEX idx_product_type ON finance_accounts(product_type);
CREATE INDEX idx_branch_code ON finance_accounts(branch_code);

-- Collection case indexes
CREATE INDEX idx_case_status_priority ON collection_cases(case_status, priority_level);
CREATE INDEX idx_case_collector ON collection_cases(assigned_collector_id);
CREATE INDEX idx_case_status ON collection_cases(case_status);

-- Activity indexes
CREATE INDEX idx_activity_date ON collection_activities(activity_datetime);
CREATE INDEX idx_activity_result ON collection_activities(activity_result);

-- Payment indexes
CREATE INDEX idx_payment_date ON payment_transactions(payment_date);
CREATE INDEX idx_payment_method ON payment_transactions(payment_method);

-- PTP indexes
CREATE INDEX idx_promise_date ON promise_to_pay(promise_date);
CREATE INDEX idx_ptp_status ON promise_to_pay(ptp_status);

-- Performance indexes
CREATE INDEX idx_collector_performance ON collector_performance(collector_id, performance_date);

-- Payment schedule indexes
CREATE INDEX idx_due_date ON payment_schedule(due_date);
CREATE INDEX idx_payment_status ON payment_schedule(payment_status);

-- =============================================
-- SECTION 9: VIEWS FOR REPORTING
-- =============================================

-- Portfolio Aging View
CREATE OR REPLACE VIEW v_portfolio_aging AS
SELECT 
    CASE 
        WHEN dpd = 0 THEN 'Current'
        WHEN dpd BETWEEN 1 AND 30 THEN 'Bucket 1 (1-30)'
        WHEN dpd BETWEEN 31 AND 60 THEN 'Bucket 2 (31-60)'
        WHEN dpd BETWEEN 61 AND 90 THEN 'Bucket 3 (61-90)'
        WHEN dpd BETWEEN 91 AND 180 THEN 'Bucket 4 (91-180)'
        ELSE 'Bucket 5 (180+)'
    END AS aging_bucket,
    COUNT(*) as account_count,
    SUM(outstanding_amount) as total_outstanding,
    AVG(dpd) as avg_dpd
FROM finance_accounts
WHERE account_status = 'Delinquent'
GROUP BY aging_bucket;

-- Daily Collection Summary View
CREATE OR REPLACE VIEW v_daily_collection_summary AS
SELECT 
    DATE(pt.payment_date) as collection_date,
    COUNT(DISTINCT pt.account_id) as accounts_collected,
    COUNT(pt.transaction_id) as total_transactions,
    SUM(pt.payment_amount) as total_collected,
    COUNT(DISTINCT pt.collected_by) as active_collectors
FROM payment_transactions pt
WHERE pt.payment_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY DATE(pt.payment_date);

-- Collector Performance View
CREATE OR REPLACE VIEW v_collector_performance_summary AS
SELECT 
    c.collector_id,
    c.employee_name,
    COUNT(DISTINCT cc.case_id) as active_cases,
    SUM(cc.total_outstanding) as total_assigned_amount,
    COUNT(DISTINCT ca.activity_id) as total_activities,
    COUNT(DISTINCT ptp.ptp_id) as total_ptps,
    SUM(CASE WHEN ptp.kept_flag = TRUE THEN 1 ELSE 0 END) as kept_ptps,
    COALESCE(SUM(pt.payment_amount), 0) as total_collected
FROM collectors c
LEFT JOIN collection_cases cc ON c.collector_id = cc.assigned_collector_id
LEFT JOIN collection_activities ca ON c.collector_id = ca.collector_id 
    AND ca.activity_datetime >= CURRENT_DATE - INTERVAL '30 days'
LEFT JOIN promise_to_pay ptp ON c.collector_id = ptp.collector_id
LEFT JOIN payment_transactions pt ON c.collector_id = pt.collected_by 
    AND pt.payment_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY c.collector_id, c.employee_name;

-- NPF by Product View
CREATE OR REPLACE VIEW v_npf_by_product AS
SELECT 
    product_type,
    COUNT(*) as total_accounts,
    SUM(CASE WHEN dpd > 90 THEN 1 ELSE 0 END) as npf_accounts,
    SUM(finance_amount) as total_financed,
    SUM(CASE WHEN dpd > 90 THEN outstanding_amount ELSE 0 END) as npf_amount,
    ROUND((SUM(CASE WHEN dpd > 90 THEN outstanding_amount ELSE 0 END)::NUMERIC / 
           NULLIF(SUM(outstanding_amount), 0)) * 100, 2) as npf_ratio
FROM finance_accounts
GROUP BY product_type;

-- PTP Success Rate View
CREATE OR REPLACE VIEW v_ptp_success_rate AS
SELECT 
    DATE(promise_date) as ptp_date,
    COUNT(*) as total_ptps,
    SUM(CASE WHEN kept_flag = TRUE THEN 1 ELSE 0 END) as kept_ptps,
    SUM(CASE WHEN ptp_status = 'Broken' THEN 1 ELSE 0 END) as broken_ptps,
    SUM(promise_amount) as total_promised,
    SUM(COALESCE(actual_payment_amount, 0)) as total_collected,
    ROUND((SUM(CASE WHEN kept_flag = TRUE THEN 1 ELSE 0 END)::NUMERIC / 
           NULLIF(COUNT(*), 0)) * 100, 2) as success_rate
FROM promise_to_pay
WHERE promise_date <= CURRENT_DATE
GROUP BY DATE(promise_date);

-- =============================================
-- SECTION 10: FUNCTIONS FOR BUSINESS LOGIC
-- =============================================

-- Function to calculate DPD (Days Past Due)
CREATE OR REPLACE FUNCTION calculate_dpd(due_date DATE, payment_date DATE DEFAULT NULL)
RETURNS INTEGER AS $$
BEGIN
    IF payment_date IS NOT NULL THEN
        RETURN 0;
    ELSE
        RETURN GREATEST(0, CURRENT_DATE - due_date);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Function to update account aging bucket
CREATE OR REPLACE FUNCTION update_account_bucket()
RETURNS TRIGGER AS $$
BEGIN
    NEW.bucket := CASE 
        WHEN NEW.dpd = 0 THEN 'Current'
        WHEN NEW.dpd BETWEEN 1 AND 30 THEN 'Bucket 1'
        WHEN NEW.dpd BETWEEN 31 AND 60 THEN 'Bucket 2'
        WHEN NEW.dpd BETWEEN 61 AND 90 THEN 'Bucket 3'
        WHEN NEW.dpd BETWEEN 91 AND 180 THEN 'Bucket 4'
        ELSE 'Bucket 5'
    END;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update bucket when DPD changes
CREATE TRIGGER trg_update_bucket
BEFORE INSERT OR UPDATE OF dpd ON finance_accounts
FOR EACH ROW
EXECUTE FUNCTION update_account_bucket();

-- Function to update PTP status
CREATE OR REPLACE FUNCTION update_ptp_status()
RETURNS VOID AS $$
BEGIN
    -- Mark overdue PTPs as broken
    UPDATE promise_to_pay
    SET ptp_status = 'Broken'
    WHERE promise_date < CURRENT_DATE
    AND ptp_status = 'Active'
    AND actual_payment_date IS NULL;
    
    -- Mark paid PTPs as kept
    UPDATE promise_to_pay
    SET ptp_status = 'Kept',
        kept_flag = TRUE
    WHERE actual_payment_amount >= promise_amount
    AND ptp_status = 'Active';
    
    -- Mark partially paid PTPs
    UPDATE promise_to_pay
    SET ptp_status = 'Partial'
    WHERE actual_payment_amount > 0
    AND actual_payment_amount < promise_amount
    AND ptp_status = 'Active';
END;
$$ LANGUAGE plpgsql;

-- =============================================
-- SECTION 11: ROW LEVEL SECURITY (RLS)
-- =============================================

-- Enable RLS on sensitive tables
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE finance_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE collection_cases ENABLE ROW LEVEL SECURITY;

-- Create policies (example for collectors accessing their assigned cases)
CREATE POLICY collector_cases_policy ON collection_cases
    FOR ALL
    TO authenticated
    USING (
        assigned_collector_id = auth.uid()
        OR EXISTS (
            SELECT 1 FROM collectors 
            WHERE collector_id = auth.uid() 
            AND collection_role IN ('Team Leader', 'Manager')
        )
    );

-- =============================================
-- SECTION 12: TRIGGERS FOR AUDIT
-- =============================================

-- Updated date trigger
CREATE OR REPLACE FUNCTION update_updated_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_date = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated date trigger to relevant tables
CREATE TRIGGER set_updated_date
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION update_updated_date();

-- =============================================
-- END OF SCHEMA
-- =============================================

-- Note: This schema is optimized for PostgreSQL/Supabase
-- Features included:
-- - PostgreSQL-specific data types and functions
-- - Row Level Security (RLS) for multi-tenant access
-- - Optimized indexes for performance
-- - Views for reporting
-- - Functions for business logic
-- - Triggers for automation