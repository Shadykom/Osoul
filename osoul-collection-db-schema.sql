-- =============================================
-- Osoul Modern Company - Collection Department
-- Database Schema and Sample Data
-- Version: 1.0
-- Created: December 2024
-- =============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS osoul_collections
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE osoul_collections;

-- =============================================
-- SECTION 1: CUSTOMER TABLES
-- =============================================

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS collector_performance;
DROP TABLE IF EXISTS sharia_compliance;
DROP TABLE IF EXISTS asset_recovery;
DROP TABLE IF EXISTS legal_cases;
DROP TABLE IF EXISTS settlements;
DROP TABLE IF EXISTS payment_transactions;
DROP TABLE IF EXISTS promise_to_pay;
DROP TABLE IF EXISTS collection_activities;
DROP TABLE IF EXISTS collection_cases;
DROP TABLE IF EXISTS payment_schedule;
DROP TABLE IF EXISTS finance_accounts;
DROP TABLE IF EXISTS customer_contacts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS collectors;

-- Customer Master Table
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    national_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    first_name_ar NVARCHAR(50),
    last_name_ar NVARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    nationality VARCHAR(50),
    employment_status VARCHAR(30),
    employer_name VARCHAR(100),
    monthly_income DECIMAL(15,2),
    credit_score INT,
    risk_category VARCHAR(20),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Customer Contact Table
CREATE TABLE customer_contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20),
    contact_type VARCHAR(20) CHECK (contact_type IN ('Mobile', 'Home', 'Work', 'Email', 'Address')),
    contact_value VARCHAR(255),
    is_primary BOOLEAN DEFAULT FALSE,
    is_valid BOOLEAN DEFAULT TRUE,
    verified_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =============================================
-- SECTION 2: FINANCE ACCOUNT TABLES
-- =============================================

-- Finance Accounts Table
CREATE TABLE finance_accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_type VARCHAR(30) CHECK (product_type IN ('Auto Finance', 'Personal Finance', 'Home Finance', 'SME Finance', 'Credit Card')),
    finance_amount DECIMAL(15,2),
    profit_rate DECIMAL(5,2),
    tenure_months INT,
    monthly_installment DECIMAL(15,2),
    outstanding_amount DECIMAL(15,2),
    principal_outstanding DECIMAL(15,2),
    profit_outstanding DECIMAL(15,2),
    origination_date DATE,
    maturity_date DATE,
    branch_code VARCHAR(10),
    officer_id VARCHAR(20),
    account_status VARCHAR(20),
    dpd INT DEFAULT 0, -- Days Past Due
    bucket VARCHAR(20),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Payment Schedule Table
CREATE TABLE payment_schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    installment_no INT,
    due_date DATE,
    principal_amount DECIMAL(15,2),
    profit_amount DECIMAL(15,2),
    total_amount DECIMAL(15,2),
    paid_amount DECIMAL(15,2) DEFAULT 0,
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    dpd INT DEFAULT 0,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id),
    INDEX idx_due_date (due_date),
    INDEX idx_payment_status (payment_status)
);

-- =============================================
-- SECTION 3: COLLECTION ACTIVITY TABLES
-- =============================================

-- Collection Cases Table
CREATE TABLE collection_cases (
    case_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
    assigned_collector_id VARCHAR(20),
    assignment_date DATE,
    case_status VARCHAR(30),
    priority_level VARCHAR(20),
    total_outstanding DECIMAL(15,2),
    last_payment_date DATE,
    last_contact_date DATETIME,
    next_action_date DATE,
    resolution_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_collector (assigned_collector_id),
    INDEX idx_status (case_status)
);

-- Collection Activities Table
CREATE TABLE collection_activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    account_id VARCHAR(20),
    collector_id VARCHAR(20),
    activity_type VARCHAR(30) CHECK (activity_type IN ('Call', 'SMS', 'Email', 'Visit', 'Letter', 'Legal Notice')),
    activity_datetime DATETIME,
    contact_person VARCHAR(100),
    contact_number VARCHAR(20),
    activity_result VARCHAR(50),
    promise_amount DECIMAL(15,2),
    promise_date DATE,
    notes TEXT,
    next_action VARCHAR(100),
    next_action_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (case_id) REFERENCES collection_cases(case_id),
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id),
    INDEX idx_activity_date (activity_datetime)
);

-- Promise to Pay (PTP) Table
CREATE TABLE promise_to_pay (
    ptp_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
    collector_id VARCHAR(20),
    promise_amount DECIMAL(15,2),
    promise_date DATE,
    ptp_status VARCHAR(20) DEFAULT 'Active',
    actual_payment_amount DECIMAL(15,2),
    actual_payment_date DATE,
    kept_flag BOOLEAN DEFAULT FALSE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (case_id) REFERENCES collection_cases(case_id),
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id),
    INDEX idx_promise_date (promise_date),
    INDEX idx_ptp_status (ptp_status)
);

-- =============================================
-- SECTION 4: PAYMENT & TRANSACTION TABLES
-- =============================================

-- Payment Transactions Table
CREATE TABLE payment_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
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
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_payment_date (payment_date)
);

-- Settlements Table
CREATE TABLE settlements (
    settlement_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
    original_outstanding DECIMAL(15,2),
    settlement_amount DECIMAL(15,2),
    discount_amount DECIMAL(15,2),
    discount_percentage DECIMAL(5,2),
    approval_level VARCHAR(30),
    approved_by VARCHAR(20),
    approval_date DATE,
    settlement_status VARCHAR(20),
    payment_plan VARCHAR(20),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id)
);

-- =============================================
-- SECTION 5: LEGAL & RECOVERY TABLES
-- =============================================

-- Legal Cases Table
CREATE TABLE legal_cases (
    legal_case_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    customer_id VARCHAR(20),
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
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id)
);

-- Asset Recovery Table
CREATE TABLE asset_recovery (
    recovery_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
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
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id)
);

-- =============================================
-- SECTION 6: EMPLOYEE & PERFORMANCE TABLES
-- =============================================

-- Collectors Table
CREATE TABLE collectors (
    collector_id VARCHAR(20) PRIMARY KEY,
    employee_name VARCHAR(100),
    employee_name_ar NVARCHAR(100),
    department VARCHAR(50),
    team_name VARCHAR(50),
    supervisor_id VARCHAR(20),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    collection_role VARCHAR(30),
    is_active BOOLEAN DEFAULT TRUE,
    join_date DATE,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Collector Performance Table
CREATE TABLE collector_performance (
    performance_id INT PRIMARY KEY AUTO_INCREMENT,
    collector_id VARCHAR(20),
    performance_date DATE,
    assigned_cases INT,
    contacted_cases INT,
    collected_amount DECIMAL(15,2),
    target_amount DECIMAL(15,2),
    ptp_obtained INT,
    ptp_kept INT,
    calls_made INT,
    visits_made INT,
    success_rate DECIMAL(5,2),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (collector_id) REFERENCES collectors(collector_id),
    INDEX idx_performance_date (performance_date)
);

-- =============================================
-- SECTION 7: SHARIA COMPLIANCE TABLES
-- =============================================

-- Sharia Compliance Table
CREATE TABLE sharia_compliance (
    compliance_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id VARCHAR(20),
    compliance_type VARCHAR(50),
    late_payment_charges DECIMAL(15,2),
    charity_amount DECIMAL(15,2),
    charity_paid_date DATE,
    profit_purification DECIMAL(15,2),
    compliance_status VARCHAR(20),
    reviewed_by VARCHAR(50),
    review_date DATE,
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES finance_accounts(account_id)
);

-- =============================================
-- SECTION 8: SAMPLE DATA INSERTION
-- =============================================

-- Insert Customers Sample Data
INSERT INTO customers (customer_id, national_id, first_name, last_name, first_name_ar, last_name_ar, 
    date_of_birth, gender, nationality, employment_status, employer_name, monthly_income, credit_score, risk_category)
VALUES
('CUST001', '1234567890', 'Ahmad', 'Al-Rashid', 'أحمد', 'الراشد', '1985-03-15', 'M', 'Saudi', 'Employed', 'Saudi Aramco', 15000, 750, 'Low'),
('CUST002', '2345678901', 'Fatima', 'Al-Zahrani', 'فاطمة', 'الزهراني', '1990-07-22', 'F', 'Saudi', 'Employed', 'Ministry of Health', 12000, 680, 'Medium'),
('CUST003', '3456789012', 'Mohammed', 'Al-Otaibi', 'محمد', 'العتيبي', '1988-11-10', 'M', 'Saudi', 'Self-Employed', 'Own Business', 20000, 620, 'High'),
('CUST004', '4567890123', 'Norah', 'Al-Harbi', 'نورة', 'الحربي', '1992-05-18', 'F', 'Saudi', 'Employed', 'STC', 10000, 700, 'Low'),
('CUST005', '5678901234', 'Khalid', 'Al-Maliki', 'خالد', 'المالكي', '1983-09-25', 'M', 'Saudi', 'Unemployed', 'None', 0, 550, 'High'),
('CUST006', '6789012345', 'Aisha', 'Al-Dosari', 'عائشة', 'الدوسري', '1987-12-03', 'F', 'Saudi', 'Employed', 'SABIC', 18000, 720, 'Low'),
('CUST007', '7890123456', 'Abdullah', 'Al-Ghamdi', 'عبدالله', 'الغامدي', '1991-06-28', 'M', 'Saudi', 'Employed', 'NCB Bank', 14000, 690, 'Medium'),
('CUST008', '8901234567', 'Maryam', 'Al-Shehri', 'مريم', 'الشهري', '1989-09-14', 'F', 'Saudi', 'Self-Employed', 'Fashion Store', 25000, 650, 'Medium'),
('CUST009', '9012345678', 'Faisal', 'Al-Anazi', 'فيصل', 'العنزي', '1984-01-20', 'M', 'Saudi', 'Employed', 'Ministry of Education', 11000, 710, 'Low'),
('CUST010', '0123456789', 'Sara', 'Al-Mutairi', 'سارة', 'المطيري', '1993-04-07', 'F', 'Saudi', 'Employed', 'King Faisal Hospital', 13000, 580, 'High');

-- Insert Customer Contacts Sample Data
INSERT INTO customer_contacts (customer_id, contact_type, contact_value, is_primary)
VALUES
('CUST001', 'Mobile', '+966501234567', TRUE),
('CUST001', 'Email', 'ahmad.rashid@email.com', FALSE),
('CUST001', 'Address', 'King Fahd Road, Riyadh 12345', FALSE),
('CUST002', 'Mobile', '+966502345678', TRUE),
('CUST002', 'Home', '+966112345678', FALSE),
('CUST003', 'Mobile', '+966503456789', TRUE),
('CUST003', 'Work', '+966114567890', FALSE),
('CUST004', 'Mobile', '+966504567890', TRUE),
('CUST005', 'Mobile', '+966505678901', TRUE),
('CUST006', 'Mobile', '+966506789012', TRUE),
('CUST006', 'Email', 'aisha.dosari@email.com', FALSE),
('CUST007', 'Mobile', '+966507890123', TRUE),
('CUST008', 'Mobile', '+966508901234', TRUE),
('CUST009', 'Mobile', '+966509012345', TRUE),
('CUST010', 'Mobile', '+966500123456', TRUE);

-- Insert Finance Accounts Sample Data
INSERT INTO finance_accounts (account_id, customer_id, product_type, finance_amount, profit_rate, 
    tenure_months, monthly_installment, outstanding_amount, principal_outstanding, profit_outstanding,
    origination_date, maturity_date, branch_code, account_status, dpd, bucket)
VALUES
('ACC001', 'CUST001', 'Auto Finance', 150000, 4.5, 60, 2812.50, 45000, 40000, 5000, '2022-01-15', '2027-01-15', 'BR001', 'Delinquent', 95, 'Bucket 4'),
('ACC002', 'CUST002', 'Personal Finance', 50000, 5.0, 36, 1500, 15000, 13000, 2000, '2023-03-20', '2026-03-20', 'BR002', 'Delinquent', 45, 'Bucket 2'),
('ACC003', 'CUST003', 'Home Finance', 800000, 3.8, 240, 4800, 750000, 700000, 50000, '2021-06-10', '2041-06-10', 'BR001', 'Delinquent', 120, 'Bucket 4'),
('ACC004', 'CUST004', 'Auto Finance', 80000, 4.5, 48, 1900, 25000, 22000, 3000, '2023-09-01', '2027-09-01', 'BR003', 'Current', 15, 'Bucket 1'),
('ACC005', 'CUST005', 'Personal Finance', 30000, 5.5, 24, 1375, 28000, 26000, 2000, '2023-12-01', '2025-12-01', 'BR002', 'Delinquent', 180, 'Bucket 5'),
('ACC006', 'CUST006', 'SME Finance', 500000, 4.2, 84, 6800, 380000, 350000, 30000, '2022-05-20', '2029-05-20', 'BR001', 'Delinquent', 65, 'Bucket 3'),
('ACC007', 'CUST007', 'Auto Finance', 120000, 4.5, 60, 2250, 85000, 78000, 7000, '2022-11-10', '2027-11-10', 'BR002', 'Delinquent', 35, 'Bucket 2'),
('ACC008', 'CUST008', 'Personal Finance', 75000, 5.0, 48, 1750, 45000, 41000, 4000, '2023-02-15', '2027-02-15', 'BR003', 'Current', 7, 'Bucket 1'),
('ACC009', 'CUST009', 'Home Finance', 600000, 3.8, 180, 4200, 520000, 490000, 30000, '2022-08-01', '2037-08-01', 'BR001', 'Delinquent', 75, 'Bucket 3'),
('ACC010', 'CUST010', 'Personal Finance', 40000, 5.5, 36, 1250, 32000, 29000, 3000, '2023-06-15', '2026-06-15', 'BR002', 'Delinquent', 150, 'Bucket 4');

-- Insert Collectors Sample Data
INSERT INTO collectors (collector_id, employee_name, employee_name_ar, department, team_name, 
    supervisor_id, contact_number, email, collection_role, join_date)
VALUES
('COL001', 'Abdulaziz Al-Rasheed', 'عبدالعزيز الرشيد', 'Collections', 'Team A', 'SUP001', 
    '+966551234567', 'abdulaziz@osoul.com', 'Senior Collector', '2020-01-15'),
('COL002', 'Sara Al-Mutairi', 'سارة المطيري', 'Collections', 'Team A', 'SUP001', 
    '+966552345678', 'sara@osoul.com', 'Collector', '2021-06-01'),
('COL003', 'Mohammed Al-Qahtani', 'محمد القحطاني', 'Collections', 'Team B', 'SUP002', 
    '+966553456789', 'mohammed@osoul.com', 'Senior Collector', '2019-03-10'),
('COL004', 'Huda Al-Shahrani', 'هدى الشهراني', 'Collections', 'Team B', 'SUP002', 
    '+966554567890', 'huda@osoul.com', 'Collector', '2022-08-20'),
('COL005', 'Omar Al-Harbi', 'عمر الحربي', 'Collections', 'Team C', 'SUP003', 
    '+966555678901', 'omar@osoul.com', 'Team Leader', '2018-11-05');

-- Insert Collection Cases Sample Data
INSERT INTO collection_cases (account_id, customer_id, assigned_collector_id, assignment_date, 
    case_status, priority_level, total_outstanding, last_payment_date, last_contact_date, next_action_date)
VALUES
('ACC001', 'CUST001', 'COL001', '2024-10-01', 'Active', 'High', 45000, '2024-09-15', '2024-12-20 10:30:00', '2024-12-22'),
('ACC002', 'CUST002', 'COL002', '2024-11-15', 'Active', 'Medium', 15000, '2024-10-20', '2024-12-19 14:15:00', '2024-12-23'),
('ACC003', 'CUST003', 'COL003', '2024-09-01', 'Legal', 'Critical', 750000, '2024-08-10', '2024-12-18 09:00:00', '2024-12-25'),
('ACC004', 'CUST004', 'COL001', '2024-12-05', 'Active', 'Low', 25000, '2024-11-30', '2024-12-21 11:45:00', '2024-12-24'),
('ACC005', 'CUST005', 'COL004', '2024-07-01', 'Write-off Review', 'Critical', 28000, '2024-06-01', '2024-12-15 16:00:00', '2024-12-30'),
('ACC006', 'CUST006', 'COL002', '2024-10-15', 'Active', 'High', 380000, '2024-09-20', '2024-12-20 15:30:00', '2024-12-26'),
('ACC007', 'CUST007', 'COL003', '2024-11-20', 'Active', 'Medium', 85000, '2024-11-01', '2024-12-19 10:00:00', '2024-12-27'),
('ACC008', 'CUST008', 'COL004', '2024-12-10', 'Active', 'Low', 45000, '2024-12-05', '2024-12-21 14:00:00', '2024-12-28'),
('ACC009', 'CUST009', 'COL005', '2024-10-25', 'Active', 'High', 520000, '2024-09-30', '2024-12-18 11:00:00', '2024-12-29'),
('ACC010', 'CUST010', 'COL001', '2024-08-15', 'Legal', 'Critical', 32000, '2024-07-10', '2024-12-17 09:30:00', '2024-12-31');

-- Insert Collection Activities Sample Data
INSERT INTO collection_activities (case_id, account_id, collector_id, activity_type, activity_datetime,
    contact_person, contact_number, activity_result, promise_amount, promise_date, notes, next_action, next_action_date)
VALUES
(1, 'ACC001', 'COL001', 'Call', '2024-12-20 10:30:00', 'Ahmad Al-Rashid', '+966501234567', 'PTP Obtained', 10000, '2024-12-25', 
    'Customer agreed to pay partial amount', 'Follow up on PTP', '2024-12-25'),
(1, 'ACC001', 'COL001', 'SMS', '2024-12-19 09:00:00', 'Ahmad Al-Rashid', '+966501234567', 'Delivered', NULL, NULL, 
    'Reminder SMS sent', 'Call customer', '2024-12-20'),
(2, 'ACC002', 'COL002', 'Call', '2024-12-19 14:15:00', 'Fatima Al-Zahrani', '+966502345678', 'No Answer', NULL, NULL, 
    'Multiple attempts, no response', 'Send SMS', '2024-12-20'),
(3, 'ACC003', 'COL003', 'Visit', '2024-12-18 09:00:00', 'Mohammed Al-Otaibi', '+966503456789', 'Customer Not Available', NULL, NULL, 
    'Neighbor confirmed customer still lives there', 'Legal Notice', '2024-12-22'),
(4, 'ACC004', 'COL001', 'Call', '2024-12-21 11:45:00', 'Norah Al-Harbi', '+966504567890', 'PTP Obtained', 5000, '2024-12-28', 
    'Customer facing temporary financial difficulty', 'Follow up', '2024-12-28'),
(5, 'ACC005', 'COL004', 'Legal Notice', '2024-12-15 16:00:00', 'Khalid Al-Maliki', '+966505678901', 'Served', NULL, NULL, 
    'Legal notice served by court officer', 'Await response', '2024-12-30'),
(6, 'ACC006', 'COL002', 'Call', '2024-12-20 15:30:00', 'Aisha Al-Dosari', '+966506789012', 'Discussed', 50000, '2024-12-30', 
    'Business facing cash flow issues', 'Follow up', '2024-12-30'),
(7, 'ACC007', 'COL003', 'Email', '2024-12-19 10:00:00', 'Abdullah Al-Ghamdi', 'abdullah@email.com', 'Sent', NULL, NULL, 
    'Detailed payment options sent via email', 'Call customer', '2024-12-21'),
(8, 'ACC008', 'COL004', 'Call', '2024-12-21 14:00:00', 'Maryam Al-Shehri', '+966508901234', 'PTP Obtained', 15000, '2024-12-26', 
    'Customer will pay after salary', 'Confirm payment', '2024-12-26'),
(9, 'ACC009', 'COL005', 'Visit', '2024-12-18 11:00:00', 'Faisal Al-Anazi', '+966509012345', 'Met Customer', 100000, '2025-01-05', 
    'Customer agreed to large payment after bonus', 'Document agreement', '2024-12-22');

-- Insert Promise to Pay Sample Data
INSERT INTO promise_to_pay (case_id, account_id, customer_id, collector_id, promise_amount, 
    promise_date, ptp_status, actual_payment_amount, actual_payment_date, kept_flag)
VALUES
(1, 'ACC001', 'CUST001', 'COL001', 10000, '2024-12-25', 'Active', NULL, NULL, FALSE),
(1, 'ACC001', 'CUST001', 'COL001', 5000, '2024-12-15', 'Broken', 0, NULL, FALSE),
(2, 'ACC002', 'CUST002', 'COL002', 3000, '2024-12-10', 'Kept', 3000, '2024-12-10', TRUE),
(4, 'ACC004', 'CUST004', 'COL001', 5000, '2024-12-28', 'Active', NULL, NULL, FALSE),
(1, 'ACC001', 'CUST001', 'COL001', 8000, '2024-11-30', 'Partial', 5000, '2024-12-02', FALSE),
(6, 'ACC006', 'CUST006', 'COL002', 50000, '2024-12-30', 'Active', NULL, NULL, FALSE),
(7, 'ACC007', 'CUST007', 'COL003', 20000, '2024-12-05', 'Kept', 20000, '2024-12-05', TRUE),
(8, 'ACC008', 'CUST008', 'COL004', 15000, '2024-12-26', 'Active', NULL, NULL, FALSE),
(9, 'ACC009', 'CUST009', 'COL005', 100000, '2025-01-05', 'Active', NULL, NULL, FALSE);

-- Insert Payment Transactions Sample Data
INSERT INTO payment_transactions (account_id, customer_id, payment_date, payment_amount, 
    payment_method, payment_channel, receipt_number, collected_by, principal_paid, profit_paid, late_fee_paid)
VALUES
('ACC001', 'CUST001', '2024-12-02', 5000, 'Cash', 'Branch', 'RCP001234', 'COL001', 4500, 500, 0),
('ACC002', 'CUST002', '2024-12-10', 3000, 'Bank Transfer', 'Online', 'ONL001235', 'System', 2600, 400, 0),
('ACC004', 'CUST004', '2024-11-30', 1900, 'Debit Card', 'ATM', 'ATM001236', 'System', 1700, 200, 0),
('ACC001', 'CUST001', '2024-11-15', 2812, 'Cash', 'Field Collection', 'FLD001237', 'COL001', 2500, 312, 0),
('ACC003', 'CUST003', '2024-08-10', 4800, 'Cheque', 'Branch', 'CHQ001238', 'Branch Staff', 4300, 500, 0),
('ACC007', 'CUST007', '2024-12-05', 20000, 'Bank Transfer', 'Mobile App', 'MOB001239', 'System', 18000, 2000, 0),
('ACC006', 'CUST006', '2024-11-20', 25000, 'Cash', 'Branch', 'RCP001240', 'Branch Staff', 22500, 2500, 0),
('ACC008', 'CUST008', '2024-12-05', 5000, 'Online Transfer', 'Internet Banking', 'ONL001241', 'System', 4500, 500, 0),
('ACC009', 'CUST009', '2024-10-30', 10000, 'Cheque', 'Branch', 'CHQ001242', 'Branch Staff', 9000, 1000, 0);

-- Insert Legal Cases Sample Data
INSERT INTO legal_cases (account_id, customer_id, case_type, court_name, case_number, 
    filing_date, lawyer_name, case_status, judgment_amount, legal_costs)
VALUES
('ACC003', 'CUST003', 'Execution', 'Riyadh General Court', 'EX2024/1234', '2024-10-15', 
    'Abdullah Legal Firm', 'Under Execution', 750000, 15000),
('ACC005', 'CUST005', 'Civil Case', 'Jeddah General Court', 'CV2024/5678', '2024-08-20', 
    'Al-Fahad Law Office', 'Judgment Obtained', 28000, 5000),
('ACC010', 'CUST010', 'Civil Case', 'Dammam General Court', 'CV2024/9012', '2024-09-10', 
    'Al-Rashid Legal Consultants', 'Filed', 32000, 3000);

-- Insert Collector Performance Sample Data
INSERT INTO collector_performance (collector_id, performance_date, assigned_cases, contacted_cases, 
    collected_amount, target_amount, ptp_obtained, ptp_kept, calls_made, visits_made, success_rate)
VALUES
('COL001', '2024-12-21', 25, 22, 125000, 150000, 8, 6, 85, 5, 83.33),
('COL002', '2024-12-21', 20, 18, 95000, 120000, 6, 4, 72, 3, 79.17),
('COL003', '2024-12-21', 30, 25, 180000, 200000, 10, 7, 110, 8, 90.00),
('COL004', '2024-12-21', 22, 20, 80000, 100000, 5, 3, 90, 4, 80.00),
('COL005', '2024-12-21', 28, 26, 210000, 250000, 12, 9, 105, 10, 84.00);

-- Insert Sharia Compliance Sample Data
INSERT INTO sharia_compliance (account_id, compliance_type, late_payment_charges, charity_amount,
    charity_paid_date, profit_purification, compliance_status, reviewed_by, review_date, notes)
VALUES
('ACC001', 'Late Payment Charges', 500, 500, '2024-12-15', 0, 'Compliant', 'Sharia Board', '2024-12-14', 
    'Late payment charges donated to approved charity'),
('ACC003', 'Profit Purification', 0, 0, NULL, 2500, 'Under Review', 'Sharia Auditor', '2024-12-20', 
    'Reviewing profit calculation for compliance'),
('ACC005', 'Late Payment Charges', 800, 800, '2024-12-10', 0, 'Compliant', 'Sharia Board', '2024-12-09', 
    'All late fees transferred to charity account');

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
WHERE pt.payment_date >= CURRENT_DATE - INTERVAL 30 DAY
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
    AND ca.activity_datetime >= CURRENT_DATE - INTERVAL 30 DAY
LEFT JOIN promise_to_pay ptp ON c.collector_id = ptp.collector_id
LEFT JOIN payment_transactions pt ON c.collector_id = pt.collected_by 
    AND pt.payment_date >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY c.collector_id, c.employee_name;

-- NPF by Product View
CREATE OR REPLACE VIEW v_npf_by_product AS
SELECT 
    product_type,
    COUNT(*) as total_accounts,
    SUM(CASE WHEN dpd > 90 THEN 1 ELSE 0 END) as npf_accounts,
    SUM(finance_amount) as total_financed,
    SUM(CASE WHEN dpd > 90 THEN outstanding_amount ELSE 0 END) as npf_amount,
    ROUND((SUM(CASE WHEN dpd > 90 THEN outstanding_amount ELSE 0 END) / SUM(outstanding_amount)) * 100, 2) as npf_ratio
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
    ROUND((SUM(CASE WHEN kept_flag = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) as success_rate
FROM promise_to_pay
WHERE promise_date <= CURRENT_DATE
GROUP BY DATE(promise_date);

-- =============================================
-- SECTION 10: INDEXES FOR PERFORMANCE
-- =============================================

-- Additional Indexes for Better Performance
CREATE INDEX idx_account_status_dpd ON finance_accounts(account_status, dpd);
CREATE INDEX idx_outstanding_amount ON finance_accounts(outstanding_amount);
CREATE INDEX idx_case_status_priority ON collection_cases(case_status, priority_level);
CREATE INDEX idx_activity_result ON collection_activities(activity_result);
CREATE INDEX idx_payment_method ON payment_transactions(payment_method);
CREATE INDEX idx_collector_performance ON collector_performance(collector_id, performance_date);
CREATE INDEX idx_customer_risk ON customers(risk_category);
CREATE INDEX idx_product_type ON finance_accounts(product_type);
CREATE INDEX idx_branch_code ON finance_accounts(branch_code);

-- =============================================
-- SECTION 11: STORED PROCEDURES FOR REPORTS
-- =============================================

DELIMITER //

-- Procedure to Calculate Daily Collection Target Achievement
CREATE PROCEDURE sp_daily_collection_report(IN p_date DATE)
BEGIN
    SELECT 
        c.collector_id,
        c.employee_name,
        cp.target_amount,
        COALESCE(SUM(pt.payment_amount), 0) as collected_amount,
        ROUND((COALESCE(SUM(pt.payment_amount), 0) / cp.target_amount) * 100, 2) as achievement_percentage
    FROM collectors c
    LEFT JOIN collector_performance cp ON c.collector_id = cp.collector_id 
        AND cp.performance_date = p_date
    LEFT JOIN payment_transactions pt ON c.collector_id = pt.collected_by 
        AND pt.payment_date = p_date
    GROUP BY c.collector_id, c.employee_name, cp.target_amount
    ORDER BY achievement_percentage DESC;
END//

-- Procedure to Get Aging Analysis by Branch
CREATE PROCEDURE sp_aging_by_branch()
BEGIN
    SELECT 
        fa.branch_code,
        COUNT(DISTINCT fa.account_id) as total_accounts,
        SUM(CASE WHEN dpd BETWEEN 1 AND 30 THEN 1 ELSE 0 END) as bucket_1,
        SUM(CASE WHEN dpd BETWEEN 31 AND 60 THEN 1 ELSE 0 END) as bucket_2,
        SUM(CASE WHEN dpd BETWEEN 61 AND 90 THEN 1 ELSE 0 END) as bucket_3,
        SUM(CASE WHEN dpd BETWEEN 91 AND 180 THEN 1 ELSE 0 END) as bucket_4,
        SUM(CASE WHEN dpd > 180 THEN 1 ELSE 0 END) as bucket_5,
        SUM(fa.outstanding_amount) as total_outstanding
    FROM finance_accounts fa
    WHERE fa.account_status = 'Delinquent'
    GROUP BY fa.branch_code;
END//

DELIMITER ;

-- =============================================
-- END OF SCHEMA
-- =============================================