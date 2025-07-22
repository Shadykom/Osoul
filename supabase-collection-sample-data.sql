-- =============================================
-- Osoul Modern Company - Collection Department
-- Sample Data for Supabase (PostgreSQL)
-- Version: 1.0
-- Created: January 2025
-- =============================================

-- Note: This script assumes the tables have already been created
-- If not, you'll need to convert the MySQL schema to PostgreSQL first

-- =============================================
-- SECTION 1: CUSTOMERS SAMPLE DATA
-- =============================================

-- Insert Customers (50 records)
INSERT INTO customers (customer_id, national_id, first_name, last_name, first_name_ar, last_name_ar, 
    date_of_birth, gender, nationality, employment_status, employer_name, monthly_income, credit_score, risk_category)
VALUES
-- High-value customers
('CUST001', '1234567890', 'Ahmad', 'Al-Rashid', 'أحمد', 'الراشد', '1985-03-15', 'M', 'Saudi', 'Employed', 'Saudi Aramco', 25000, 750, 'Low'),
('CUST002', '2345678901', 'Fatima', 'Al-Zahrani', 'فاطمة', 'الزهراني', '1990-07-22', 'F', 'Saudi', 'Employed', 'Ministry of Health', 18000, 680, 'Medium'),
('CUST003', '3456789012', 'Mohammed', 'Al-Otaibi', 'محمد', 'العتيبي', '1988-11-10', 'M', 'Saudi', 'Self-Employed', 'Own Business', 35000, 620, 'High'),
('CUST004', '4567890123', 'Norah', 'Al-Harbi', 'نورة', 'الحربي', '1992-05-18', 'F', 'Saudi', 'Employed', 'STC', 15000, 700, 'Low'),
('CUST005', '5678901234', 'Khalid', 'Al-Maliki', 'خالد', 'المالكي', '1983-09-25', 'M', 'Saudi', 'Unemployed', NULL, 0, 550, 'High'),
('CUST006', '6789012345', 'Aisha', 'Al-Dosari', 'عائشة', 'الدوسري', '1987-12-03', 'F', 'Saudi', 'Employed', 'SABIC', 22000, 720, 'Low'),
('CUST007', '7890123456', 'Abdullah', 'Al-Ghamdi', 'عبدالله', 'الغامدي', '1991-06-28', 'M', 'Saudi', 'Employed', 'Al Rajhi Bank', 16000, 690, 'Medium'),
('CUST008', '8901234567', 'Maryam', 'Al-Shehri', 'مريم', 'الشهري', '1989-09-14', 'F', 'Saudi', 'Self-Employed', 'Fashion Store', 28000, 650, 'Medium'),
('CUST009', '9012345678', 'Faisal', 'Al-Anazi', 'فيصل', 'العنزي', '1984-01-20', 'M', 'Saudi', 'Employed', 'Ministry of Education', 14000, 710, 'Low'),
('CUST010', '0123456789', 'Sara', 'Al-Mutairi', 'سارة', 'المطيري', '1993-04-07', 'F', 'Saudi', 'Employed', 'King Faisal Hospital', 17000, 580, 'High'),
-- Medium-value customers
('CUST011', '1122334455', 'Omar', 'Al-Qahtani', 'عمر', 'القحطاني', '1986-08-12', 'M', 'Saudi', 'Employed', 'Saudi Telecom', 13000, 670, 'Medium'),
('CUST012', '2233445566', 'Layla', 'Al-Shammari', 'ليلى', 'الشمري', '1994-02-28', 'F', 'Saudi', 'Employed', 'Flynas', 11000, 640, 'Medium'),
('CUST013', '3344556677', 'Yousef', 'Al-Enezi', 'يوسف', 'العنزي', '1982-11-05', 'M', 'Saudi', 'Self-Employed', 'Trading Company', 20000, 600, 'High'),
('CUST014', '4455667788', 'Huda', 'Al-Dossari', 'هدى', 'الدوسري', '1995-06-15', 'F', 'Saudi', 'Employed', 'KPMG', 14500, 695, 'Low'),
('CUST015', '5566778899', 'Turki', 'Al-Subaie', 'تركي', 'السبيعي', '1988-03-22', 'M', 'Saudi', 'Employed', 'NEOM', 30000, 730, 'Low'),
('CUST016', '6677889900', 'Reem', 'Al-Rashidi', 'ريم', 'الرشيدي', '1991-09-08', 'F', 'Saudi', 'Employed', 'PwC', 16500, 685, 'Medium'),
('CUST017', '7788990011', 'Majed', 'Al-Otaibi', 'ماجد', 'العتيبي', '1985-12-17', 'M', 'Saudi', 'Employed', 'Saudi Airlines', 18500, 660, 'Medium'),
('CUST018', '8899001122', 'Nouf', 'Al-Harbi', 'نوف', 'الحربي', '1993-07-03', 'F', 'Saudi', 'Employed', 'Deloitte', 15500, 705, 'Low'),
('CUST019', '9900112233', 'Saleh', 'Al-Ghamdi', 'صالح', 'الغامدي', '1987-04-25', 'M', 'Saudi', 'Self-Employed', 'Restaurant Owner', 25000, 630, 'Medium'),
('CUST020', '0011223344', 'Dalal', 'Al-Zahrani', 'دلال', 'الزهراني', '1996-01-14', 'F', 'Saudi', 'Employed', 'Ernst & Young', 13500, 675, 'Medium'),
-- Regular customers
('CUST021', '1234561111', 'Hamad', 'Al-Tamimi', 'حمد', 'التميمي', '1989-05-20', 'M', 'Saudi', 'Employed', 'Local Company', 9000, 620, 'Medium'),
('CUST022', '2345672222', 'Asma', 'Al-Khatib', 'أسماء', 'الخطيب', '1992-10-15', 'F', 'Saudi', 'Employed', 'School Teacher', 10000, 650, 'Medium'),
('CUST023', '3456783333', 'Nawaf', 'Al-Shahrani', 'نواف', 'الشهراني', '1986-07-08', 'M', 'Saudi', 'Employed', 'Municipality', 11500, 640, 'Medium'),
('CUST024', '4567894444', 'Hessa', 'Al-Sulaiman', 'حصة', 'السليمان', '1994-03-25', 'F', 'Saudi', 'Employed', 'Private Clinic', 12000, 660, 'Medium'),
('CUST025', '5678905555', 'Bandar', 'Al-Rasheed', 'بندر', 'الرشيد', '1983-12-01', 'M', 'Saudi', 'Self-Employed', 'Small Shop', 8000, 590, 'High'),
('CUST026', '6789016666', 'Munira', 'Al-Faisal', 'منيرة', 'الفيصل', '1991-08-18', 'F', 'Saudi', 'Employed', 'Bank Clerk', 9500, 670, 'Medium'),
('CUST027', '7890127777', 'Saud', 'Al-Mutlaq', 'سعود', 'المطلق', '1988-02-14', 'M', 'Saudi', 'Employed', 'Government', 13000, 680, 'Low'),
('CUST028', '8901238888', 'Jawaher', 'Al-Rashid', 'جواهر', 'الراشد', '1995-11-22', 'F', 'Saudi', 'Employed', 'Retail Store', 8500, 630, 'Medium'),
('CUST029', '9012349999', 'Meshal', 'Al-Qahtani', 'مشعل', 'القحطاني', '1985-06-30', 'M', 'Saudi', 'Employed', 'Construction', 10500, 610, 'High'),
('CUST030', '0123450000', 'Abeer', 'Al-Harbi', 'عبير', 'الحربي', '1993-09-12', 'F', 'Saudi', 'Employed', 'Healthcare', 11000, 655, 'Medium'),
-- Lower-income customers
('CUST031', '1111222233', 'Fahad', 'Al-Dakhil', 'فهد', 'الدخيل', '1990-04-05', 'M', 'Saudi', 'Employed', 'Security Guard', 5000, 580, 'High'),
('CUST032', '2222333344', 'Wafa', 'Al-Salem', 'وفاء', 'السالم', '1987-11-28', 'F', 'Saudi', 'Employed', 'Cashier', 4500, 570, 'High'),
('CUST033', '3333444455', 'Nasser', 'Al-Otaibi', 'ناصر', 'العتيبي', '1984-08-15', 'M', 'Saudi', 'Part-time', 'Uber Driver', 6000, 590, 'High'),
('CUST034', '4444555566', 'Ghada', 'Al-Rasheed', 'غادة', 'الرشيد', '1992-05-03', 'F', 'Saudi', 'Unemployed', NULL, 0, 540, 'High'),
('CUST035', '5555666677', 'Waleed', 'Al-Subaie', 'وليد', 'السبيعي', '1989-01-20', 'M', 'Saudi', 'Employed', 'Warehouse Worker', 5500, 585, 'High'),
('CUST036', '6666777788', 'Haifa', 'Al-Maliki', 'هيفاء', 'المالكي', '1994-10-08', 'F', 'Saudi', 'Employed', 'Call Center', 6500, 600, 'Medium'),
('CUST037', '7777888899', 'Adel', 'Al-Harbi', 'عادل', 'الحربي', '1986-07-25', 'M', 'Saudi', 'Self-Employed', 'Taxi Driver', 7000, 595, 'High'),
('CUST038', '8888999900', 'Basma', 'Al-Zahrani', 'بسمة', 'الزهراني', '1991-03-12', 'F', 'Saudi', 'Employed', 'Receptionist', 5800, 605, 'Medium'),
('CUST039', '9999000011', 'Rashed', 'Al-Ghamdi', 'راشد', 'الغامدي', '1988-12-28', 'M', 'Saudi', 'Employed', 'Delivery Driver', 6200, 575, 'High'),
('CUST040', '0000111122', 'Latifa', 'Al-Otaibi', 'لطيفة', 'العتيبي', '1993-06-15', 'F', 'Saudi', 'Part-time', 'Home Business', 4000, 560, 'High'),
-- Additional customers
('CUST041', '1212121212', 'Ibrahim', 'Al-Saud', 'إبراهيم', 'آل سعود', '1985-09-10', 'M', 'Saudi', 'Employed', 'Oil Company', 28000, 740, 'Low'),
('CUST042', '2323232323', 'Amal', 'Al-Rasheed', 'أمل', 'الرشيد', '1990-02-25', 'F', 'Saudi', 'Employed', 'University Professor', 19000, 710, 'Low'),
('CUST043', '3434343434', 'Sultan', 'Al-Qahtani', 'سلطان', 'القحطاني', '1987-11-15', 'M', 'Saudi', 'Self-Employed', 'IT Consultant', 32000, 690, 'Medium'),
('CUST044', '4545454545', 'Maha', 'Al-Shehri', 'مها', 'الشهري', '1992-08-05', 'F', 'Saudi', 'Employed', 'Marketing Manager', 16000, 700, 'Low'),
('CUST045', '5656565656', 'Yasir', 'Al-Harbi', 'ياسر', 'الحربي', '1984-05-20', 'M', 'Saudi', 'Employed', 'Engineer', 21000, 680, 'Medium'),
('CUST046', '6767676767', 'Shahad', 'Al-Otaibi', 'شهد', 'العتيبي', '1995-12-10', 'F', 'Saudi', 'Employed', 'HR Specialist', 12500, 665, 'Medium'),
('CUST047', '7878787878', 'Mishal', 'Al-Ghamdi', 'مشعل', 'الغامدي', '1989-03-30', 'M', 'Saudi', 'Employed', 'Accountant', 14000, 695, 'Low'),
('CUST048', '8989898989', 'Lulwa', 'Al-Zahrani', 'لولوة', 'الزهراني', '1991-10-18', 'F', 'Saudi', 'Employed', 'Pharmacist', 15500, 705, 'Low'),
('CUST049', '9090909090', 'Ziyad', 'Al-Mutairi', 'زياد', 'المطيري', '1986-07-08', 'M', 'Saudi', 'Self-Employed', 'Real Estate', 45000, 630, 'Medium'),
('CUST050', '0101010101', 'Jawaher', 'Al-Subaie', 'جواهر', 'السبيعي', '1994-04-22', 'F', 'Saudi', 'Employed', 'Interior Designer', 13000, 675, 'Medium');

-- =============================================
-- SECTION 2: CUSTOMER CONTACTS
-- =============================================

-- Insert Customer Contacts (multiple per customer)
INSERT INTO customer_contacts (customer_id, contact_type, contact_value, is_primary, is_valid, verified_date)
VALUES
-- Primary contacts
('CUST001', 'Mobile', '+966501234567', true, true, '2024-01-15'),
('CUST002', 'Mobile', '+966502345678', true, true, '2024-01-15'),
('CUST003', 'Mobile', '+966503456789', true, true, '2024-01-15'),
('CUST004', 'Mobile', '+966504567890', true, true, '2024-01-15'),
('CUST005', 'Mobile', '+966505678901', true, true, '2024-01-15'),
('CUST006', 'Mobile', '+966506789012', true, true, '2024-01-15'),
('CUST007', 'Mobile', '+966507890123', true, true, '2024-01-15'),
('CUST008', 'Mobile', '+966508901234', true, true, '2024-01-15'),
('CUST009', 'Mobile', '+966509012345', true, true, '2024-01-15'),
('CUST010', 'Mobile', '+966500123456', true, true, '2024-01-15'),
-- Secondary contacts
('CUST001', 'Email', 'ahmad.rashid@email.com', false, true, '2024-01-15'),
('CUST001', 'Address', 'King Fahd Road, Riyadh 12345', false, true, '2024-01-15'),
('CUST002', 'Home', '+966112345678', false, true, '2024-01-15'),
('CUST003', 'Work', '+966114567890', false, true, '2024-01-15'),
('CUST003', 'Email', 'mohammed.otaibi@business.com', false, true, '2024-01-15'),
('CUST004', 'Email', 'norah.harbi@email.com', false, true, '2024-01-15'),
('CUST005', 'Address', 'Al Olaya District, Riyadh 11111', false, true, '2024-01-15'),
('CUST006', 'Email', 'aisha.dosari@email.com', false, true, '2024-01-15'),
('CUST006', 'Work', '+966113456789', false, true, '2024-01-15'),
('CUST007', 'Email', 'abdullah.ghamdi@email.com', false, true, '2024-01-15'),
('CUST008', 'Work', '+966115678901', false, true, '2024-01-15'),
('CUST009', 'Home', '+966116789012', false, true, '2024-01-15'),
('CUST010', 'Email', 'sara.mutairi@email.com', false, true, '2024-01-15'),
-- Additional contacts for other customers (adding primary mobile for each)
('CUST011', 'Mobile', '+966511111111', true, true, '2024-01-15'),
('CUST012', 'Mobile', '+966512222222', true, true, '2024-01-15'),
('CUST013', 'Mobile', '+966513333333', true, true, '2024-01-15'),
('CUST014', 'Mobile', '+966514444444', true, true, '2024-01-15'),
('CUST015', 'Mobile', '+966515555555', true, true, '2024-01-15'),
('CUST016', 'Mobile', '+966516666666', true, true, '2024-01-15'),
('CUST017', 'Mobile', '+966517777777', true, true, '2024-01-15'),
('CUST018', 'Mobile', '+966518888888', true, true, '2024-01-15'),
('CUST019', 'Mobile', '+966519999999', true, true, '2024-01-15'),
('CUST020', 'Mobile', '+966520000000', true, true, '2024-01-15'),
('CUST021', 'Mobile', '+966521111111', true, true, '2024-01-15'),
('CUST022', 'Mobile', '+966522222222', true, true, '2024-01-15'),
('CUST023', 'Mobile', '+966523333333', true, true, '2024-01-15'),
('CUST024', 'Mobile', '+966524444444', true, true, '2024-01-15'),
('CUST025', 'Mobile', '+966525555555', true, true, '2024-01-15'),
('CUST026', 'Mobile', '+966526666666', true, true, '2024-01-15'),
('CUST027', 'Mobile', '+966527777777', true, true, '2024-01-15'),
('CUST028', 'Mobile', '+966528888888', true, true, '2024-01-15'),
('CUST029', 'Mobile', '+966529999999', true, true, '2024-01-15'),
('CUST030', 'Mobile', '+966530000000', true, true, '2024-01-15'),
('CUST031', 'Mobile', '+966531111111', true, true, '2024-01-15'),
('CUST032', 'Mobile', '+966532222222', true, true, '2024-01-15'),
('CUST033', 'Mobile', '+966533333333', true, true, '2024-01-15'),
('CUST034', 'Mobile', '+966534444444', true, true, '2024-01-15'),
('CUST035', 'Mobile', '+966535555555', true, true, '2024-01-15'),
('CUST036', 'Mobile', '+966536666666', true, true, '2024-01-15'),
('CUST037', 'Mobile', '+966537777777', true, true, '2024-01-15'),
('CUST038', 'Mobile', '+966538888888', true, true, '2024-01-15'),
('CUST039', 'Mobile', '+966539999999', true, true, '2024-01-15'),
('CUST040', 'Mobile', '+966540000000', true, true, '2024-01-15'),
('CUST041', 'Mobile', '+966541111111', true, true, '2024-01-15'),
('CUST042', 'Mobile', '+966542222222', true, true, '2024-01-15'),
('CUST043', 'Mobile', '+966543333333', true, true, '2024-01-15'),
('CUST044', 'Mobile', '+966544444444', true, true, '2024-01-15'),
('CUST045', 'Mobile', '+966545555555', true, true, '2024-01-15'),
('CUST046', 'Mobile', '+966546666666', true, true, '2024-01-15'),
('CUST047', 'Mobile', '+966547777777', true, true, '2024-01-15'),
('CUST048', 'Mobile', '+966548888888', true, true, '2024-01-15'),
('CUST049', 'Mobile', '+966549999999', true, true, '2024-01-15'),
('CUST050', 'Mobile', '+966550000000', true, true, '2024-01-15');

-- =============================================
-- SECTION 3: FINANCE ACCOUNTS
-- =============================================

-- Insert Finance Accounts (multiple accounts per customer)
INSERT INTO finance_accounts (account_id, customer_id, product_type, finance_amount, profit_rate, 
    tenure_months, monthly_installment, outstanding_amount, principal_outstanding, profit_outstanding,
    origination_date, maturity_date, branch_code, officer_id, account_status, dpd, bucket)
VALUES
-- High-value delinquent accounts
('ACC001', 'CUST001', 'Auto Finance', 250000, 4.5, 60, 4687.50, 125000, 115000, 10000, '2021-01-15', '2026-01-15', 'BR001', 'OFF001', 'Delinquent', 95, 'Bucket 4'),
('ACC002', 'CUST002', 'Personal Finance', 75000, 5.0, 36, 2250, 35000, 32000, 3000, '2022-03-20', '2025-03-20', 'BR002', 'OFF002', 'Delinquent', 45, 'Bucket 2'),
('ACC003', 'CUST003', 'Home Finance', 1200000, 3.8, 240, 7200, 950000, 900000, 50000, '2020-06-10', '2040-06-10', 'BR001', 'OFF001', 'Delinquent', 120, 'Bucket 4'),
('ACC004', 'CUST004', 'Auto Finance', 180000, 4.5, 48, 4275, 65000, 60000, 5000, '2022-09-01', '2026-09-01', 'BR003', 'OFF003', 'Delinquent', 15, 'Bucket 1'),
('ACC005', 'CUST005', 'Personal Finance', 50000, 5.5, 24, 2291.67, 48000, 46000, 2000, '2023-01-01', '2025-01-01', 'BR002', 'OFF002', 'Delinquent', 180, 'Bucket 5'),
('ACC006', 'CUST006', 'SME Finance', 800000, 4.2, 84, 11333.33, 580000, 550000, 30000, '2021-05-20', '2028-05-20', 'BR001', 'OFF001', 'Delinquent', 65, 'Bucket 3'),
('ACC007', 'CUST007', 'Auto Finance', 220000, 4.5, 60, 4125, 145000, 138000, 7000, '2021-11-10', '2026-11-10', 'BR002', 'OFF002', 'Delinquent', 35, 'Bucket 2'),
('ACC008', 'CUST008', 'Personal Finance', 100000, 5.0, 48, 2291.67, 65000, 61000, 4000, '2022-02-15', '2026-02-15', 'BR003', 'OFF003', 'Current', 7, 'Bucket 1'),
('ACC009', 'CUST009', 'Home Finance', 900000, 3.8, 180, 6300, 720000, 690000, 30000, '2021-08-01', '2036-08-01', 'BR001', 'OFF001', 'Delinquent', 75, 'Bucket 3'),
('ACC010', 'CUST010', 'Personal Finance', 60000, 5.5, 36, 1833.33, 42000, 39000, 3000, '2022-06-15', '2025-06-15', 'BR002', 'OFF002', 'Delinquent', 150, 'Bucket 4'),
-- Medium-value accounts
('ACC011', 'CUST011', 'Auto Finance', 150000, 4.5, 48, 3562.50, 85000, 80000, 5000, '2022-04-10', '2026-04-10', 'BR001', 'OFF001', 'Delinquent', 55, 'Bucket 2'),
('ACC012', 'CUST012', 'Personal Finance', 45000, 5.0, 24, 2062.50, 25000, 23000, 2000, '2023-02-20', '2025-02-20', 'BR002', 'OFF002', 'Delinquent', 25, 'Bucket 1'),
('ACC013', 'CUST013', 'SME Finance', 500000, 4.2, 60, 9333.33, 350000, 330000, 20000, '2021-10-15', '2026-10-15', 'BR003', 'OFF003', 'Delinquent', 90, 'Bucket 3'),
('ACC014', 'CUST014', 'Personal Finance', 80000, 5.0, 36, 2400, 45000, 42000, 3000, '2022-07-01', '2025-07-01', 'BR001', 'OFF001', 'Current', 10, 'Bucket 1'),
('ACC015', 'CUST015', 'Home Finance', 1500000, 3.8, 240, 9000, 1350000, 1300000, 50000, '2021-03-25', '2041-03-25', 'BR002', 'OFF002', 'Delinquent', 40, 'Bucket 2'),
('ACC016', 'CUST016', 'Auto Finance', 200000, 4.5, 60, 3750, 120000, 113000, 7000, '2022-01-10', '2027-01-10', 'BR003', 'OFF003', 'Delinquent', 60, 'Bucket 3'),
('ACC017', 'CUST017', 'Personal Finance', 90000, 5.0, 48, 2062.50, 55000, 52000, 3000, '2022-05-15', '2026-05-15', 'BR001', 'OFF001', 'Delinquent', 85, 'Bucket 3'),
('ACC018', 'CUST018', 'Auto Finance', 170000, 4.5, 48, 4037.50, 95000, 90000, 5000, '2022-08-20', '2026-08-20', 'BR002', 'OFF002', 'Current', 5, 'Bucket 1'),
('ACC019', 'CUST019', 'SME Finance', 600000, 4.2, 72, 10000, 420000, 400000, 20000, '2021-12-01', '2027-12-01', 'BR003', 'OFF003', 'Delinquent', 110, 'Bucket 4'),
('ACC020', 'CUST020', 'Personal Finance', 70000, 5.0, 36, 2100, 38000, 35000, 3000, '2022-09-10', '2025-09-10', 'BR001', 'OFF001', 'Delinquent', 30, 'Bucket 2'),
-- Lower-value accounts
('ACC021', 'CUST021', 'Personal Finance', 30000, 5.5, 24, 1375, 18000, 17000, 1000, '2023-03-15', '2025-03-15', 'BR002', 'OFF002', 'Delinquent', 70, 'Bucket 3'),
('ACC022', 'CUST022', 'Auto Finance', 80000, 4.5, 36, 2375, 45000, 42000, 3000, '2022-10-20', '2025-10-20', 'BR003', 'OFF003', 'Delinquent', 50, 'Bucket 2'),
('ACC023', 'CUST023', 'Personal Finance', 40000, 5.5, 24, 1833.33, 22000, 20500, 1500, '2023-01-25', '2025-01-25', 'BR001', 'OFF001', 'Delinquent', 95, 'Bucket 4'),
('ACC024', 'CUST024', 'Auto Finance', 100000, 4.5, 48, 2375, 58000, 55000, 3000, '2022-06-30', '2026-06-30', 'BR002', 'OFF002', 'Delinquent', 20, 'Bucket 1'),
('ACC025', 'CUST025', 'Personal Finance', 25000, 5.5, 18, 1458.33, 15000, 14000, 1000, '2023-04-05', '2024-10-05', 'BR003', 'OFF003', 'Delinquent', 160, 'Bucket 5'),
('ACC026', 'CUST026', 'Auto Finance', 90000, 4.5, 36, 2675, 48000, 45000, 3000, '2022-11-15', '2025-11-15', 'BR001', 'OFF001', 'Delinquent', 45, 'Bucket 2'),
('ACC027', 'CUST027', 'Personal Finance', 50000, 5.0, 36, 1500, 28000, 26000, 2000, '2022-08-10', '2025-08-10', 'BR002', 'OFF002', 'Current', 12, 'Bucket 1'),
('ACC028', 'CUST028', 'Auto Finance', 70000, 4.5, 36, 2083.33, 38000, 35500, 2500, '2022-12-20', '2025-12-20', 'BR003', 'OFF003', 'Delinquent', 80, 'Bucket 3'),
('ACC029', 'CUST029', 'Personal Finance', 35000, 5.5, 24, 1604.17, 20000, 18500, 1500, '2023-02-15', '2025-02-15', 'BR001', 'OFF001', 'Delinquent', 125, 'Bucket 4'),
('ACC030', 'CUST030', 'Auto Finance', 110000, 4.5, 48, 2612.50, 62000, 58000, 4000, '2022-07-25', '2026-07-25', 'BR002', 'OFF002', 'Delinquent', 55, 'Bucket 2'),
-- Additional accounts for portfolio diversity
('ACC031', 'CUST031', 'Personal Finance', 20000, 6.0, 18, 1166.67, 15000, 14000, 1000, '2023-05-10', '2024-11-10', 'BR003', 'OFF003', 'Delinquent', 200, 'Bucket 5'),
('ACC032', 'CUST032', 'Auto Finance', 60000, 4.5, 36, 1785, 32000, 30000, 2000, '2023-01-15', '2026-01-15', 'BR001', 'OFF001', 'Delinquent', 140, 'Bucket 4'),
('ACC033', 'CUST033', 'Personal Finance', 30000, 5.5, 24, 1375, 18000, 16500, 1500, '2023-03-20', '2025-03-20', 'BR002', 'OFF002', 'Delinquent', 100, 'Bucket 4'),
('ACC034', 'CUST034', 'Personal Finance', 15000, 6.0, 12, 1291.67, 12000, 11500, 500, '2023-06-01', '2024-06-01', 'BR003', 'OFF003', 'Delinquent', 220, 'Bucket 5'),
('ACC035', 'CUST035', 'Auto Finance', 75000, 4.5, 36, 2232.50, 40000, 37500, 2500, '2022-09-15', '2025-09-15', 'BR001', 'OFF001', 'Delinquent', 115, 'Bucket 4'),
('ACC036', 'CUST036', 'Personal Finance', 40000, 5.0, 36, 1200, 22000, 20000, 2000, '2022-11-20', '2025-11-20', 'BR002', 'OFF002', 'Delinquent', 75, 'Bucket 3'),
('ACC037', 'CUST037', 'Auto Finance', 85000, 4.5, 48, 2018.75, 48000, 45000, 3000, '2022-04-25', '2026-04-25', 'BR003', 'OFF003', 'Delinquent', 165, 'Bucket 5'),
('ACC038', 'CUST038', 'Personal Finance', 35000, 5.5, 24, 1604.17, 20000, 18500, 1500, '2023-02-10', '2025-02-10', 'BR001', 'OFF001', 'Delinquent', 85, 'Bucket 3'),
('ACC039', 'CUST039', 'Auto Finance', 65000, 4.5, 36, 1935, 35000, 32500, 2500, '2022-12-05', '2025-12-05', 'BR002', 'OFF002', 'Delinquent', 130, 'Bucket 4'),
('ACC040', 'CUST040', 'Personal Finance', 25000, 6.0, 18, 1458.33, 18000, 17000, 1000, '2023-04-15', '2024-10-15', 'BR003', 'OFF003', 'Delinquent', 190, 'Bucket 5'),
-- High-value additional accounts
('ACC041', 'CUST041', 'Home Finance', 2000000, 3.8, 240, 12000, 1850000, 1800000, 50000, '2020-09-10', '2040-09-10', 'BR001', 'OFF001', 'Delinquent', 25, 'Bucket 1'),
('ACC042', 'CUST042', 'Auto Finance', 300000, 4.5, 60, 5625, 180000, 170000, 10000, '2021-02-25', '2026-02-25', 'BR002', 'OFF002', 'Delinquent', 40, 'Bucket 2'),
('ACC043', 'CUST043', 'SME Finance', 1000000, 4.2, 96, 13333.33, 750000, 720000, 30000, '2020-11-15', '2028-11-15', 'BR003', 'OFF003', 'Delinquent', 60, 'Bucket 3'),
('ACC044', 'CUST044', 'Personal Finance', 120000, 5.0, 48, 2750, 75000, 70000, 5000, '2022-03-05', '2026-03-05', 'BR001', 'OFF001', 'Current', 8, 'Bucket 1'),
('ACC045', 'CUST045', 'Auto Finance', 280000, 4.5, 60, 5250, 165000, 155000, 10000, '2021-05-20', '2026-05-20', 'BR002', 'OFF002', 'Delinquent', 70, 'Bucket 3'),
('ACC046', 'CUST046', 'Personal Finance', 85000, 5.0, 36, 2550, 48000, 45000, 3000, '2022-07-15', '2025-07-15', 'BR003', 'OFF003', 'Delinquent', 35, 'Bucket 2'),
('ACC047', 'CUST047', 'Auto Finance', 190000, 4.5, 48, 4512.50, 105000, 98000, 7000, '2022-01-30', '2026-01-30', 'BR001', 'OFF001', 'Delinquent', 50, 'Bucket 2'),
('ACC048', 'CUST048', 'Personal Finance', 95000, 5.0, 48, 2177.08, 58000, 54000, 4000, '2022-04-18', '2026-04-18', 'BR002', 'OFF002', 'Current', 15, 'Bucket 1'),
('ACC049', 'CUST049', 'SME Finance', 1500000, 4.2, 120, 17500, 1200000, 1150000, 50000, '2020-07-08', '2030-07-08', 'BR003', 'OFF003', 'Delinquent', 95, 'Bucket 4'),
('ACC050', 'CUST050', 'Personal Finance', 65000, 5.0, 36, 1950, 36000, 33000, 3000, '2022-10-22', '2025-10-22', 'BR001', 'OFF001', 'Delinquent', 42, 'Bucket 2');

-- =============================================
-- SECTION 4: COLLECTORS
-- =============================================

INSERT INTO collectors (collector_id, employee_name, employee_name_ar, department, team_name, 
    supervisor_id, contact_number, email, collection_role, is_active, join_date)
VALUES
('COL001', 'Abdulaziz Al-Rasheed', 'عبدالعزيز الرشيد', 'Collections', 'Team A', 'SUP001', 
    '+966551234567', 'abdulaziz.rasheed@osoul.com', 'Senior Collector', true, '2020-01-15'),
('COL002', 'Sara Al-Mutairi', 'سارة المطيري', 'Collections', 'Team A', 'SUP001', 
    '+966552345678', 'sara.mutairi@osoul.com', 'Collector', true, '2021-06-01'),
('COL003', 'Mohammed Al-Qahtani', 'محمد القحطاني', 'Collections', 'Team B', 'SUP002', 
    '+966553456789', 'mohammed.qahtani@osoul.com', 'Senior Collector', true, '2019-03-10'),
('COL004', 'Huda Al-Shahrani', 'هدى الشهراني', 'Collections', 'Team B', 'SUP002', 
    '+966554567890', 'huda.shahrani@osoul.com', 'Collector', true, '2022-08-20'),
('COL005', 'Omar Al-Harbi', 'عمر الحربي', 'Collections', 'Team C', 'SUP003', 
    '+966555678901', 'omar.harbi@osoul.com', 'Team Leader', true, '2018-11-05'),
('COL006', 'Fatima Al-Zahrani', 'فاطمة الزهراني', 'Collections', 'Team C', 'SUP003', 
    '+966556789012', 'fatima.zahrani@osoul.com', 'Senior Collector', true, '2020-04-12'),
('COL007', 'Khalid Al-Otaibi', 'خالد العتيبي', 'Collections', 'Team A', 'SUP001', 
    '+966557890123', 'khalid.otaibi@osoul.com', 'Collector', true, '2023-01-08'),
('COL008', 'Noura Al-Ghamdi', 'نورة الغامدي', 'Collections', 'Team B', 'SUP002', 
    '+966558901234', 'noura.ghamdi@osoul.com', 'Collector', true, '2022-11-15'),
('COL009', 'Faisal Al-Enezi', 'فيصل العنزي', 'Collections', 'Team C', 'SUP003', 
    '+966559012345', 'faisal.enezi@osoul.com', 'Senior Collector', true, '2021-02-20'),
('COL010', 'Amal Al-Shehri', 'أمل الشهري', 'Collections', 'Team A', 'SUP001', 
    '+966550123456', 'amal.shehri@osoul.com', 'Collector', true, '2023-03-25');

-- =============================================
-- SECTION 5: COLLECTION CASES
-- =============================================

INSERT INTO collection_cases (account_id, customer_id, assigned_collector_id, assignment_date, 
    case_status, priority_level, total_outstanding, last_payment_date, last_contact_date, next_action_date)
VALUES
-- High priority cases
('ACC001', 'CUST001', 'COL001', '2024-10-01', 'Active', 'High', 125000, '2024-09-15', '2025-01-20 10:30:00', '2025-01-22'),
('ACC002', 'CUST002', 'COL002', '2024-11-15', 'Active', 'Medium', 35000, '2024-10-20', '2025-01-19 14:15:00', '2025-01-23'),
('ACC003', 'CUST003', 'COL003', '2024-09-01', 'Legal', 'Critical', 950000, '2024-08-10', '2025-01-18 09:00:00', '2025-01-25'),
('ACC004', 'CUST004', 'COL001', '2024-12-05', 'Active', 'Low', 65000, '2024-11-30', '2025-01-21 11:45:00', '2025-01-24'),
('ACC005', 'CUST005', 'COL004', '2024-07-01', 'Write-off Review', 'Critical', 48000, '2024-06-01', '2025-01-15 16:00:00', '2025-01-30'),
('ACC006', 'CUST006', 'COL002', '2024-10-15', 'Active', 'High', 580000, '2024-09-20', '2025-01-20 15:30:00', '2025-01-26'),
('ACC007', 'CUST007', 'COL003', '2024-11-20', 'Active', 'Medium', 145000, '2024-11-01', '2025-01-19 10:00:00', '2025-01-27'),
('ACC008', 'CUST008', 'COL004', '2024-12-10', 'Active', 'Low', 65000, '2024-12-05', '2025-01-21 14:00:00', '2025-01-28'),
('ACC009', 'CUST009', 'COL005', '2024-10-25', 'Active', 'High', 720000, '2024-09-30', '2025-01-18 11:00:00', '2025-01-29'),
('ACC010', 'CUST010', 'COL001', '2024-08-15', 'Legal', 'Critical', 42000, '2024-07-10', '2025-01-17 09:30:00', '2025-01-31'),
-- Medium priority cases
('ACC011', 'CUST011', 'COL006', '2024-11-01', 'Active', 'Medium', 85000, '2024-10-15', '2025-01-20 09:00:00', '2025-01-23'),
('ACC012', 'CUST012', 'COL007', '2024-12-15', 'Active', 'Low', 25000, '2024-12-01', '2025-01-21 10:30:00', '2025-01-24'),
('ACC013', 'CUST013', 'COL008', '2024-10-20', 'Active', 'High', 350000, '2024-09-25', '2025-01-19 11:15:00', '2025-01-25'),
('ACC014', 'CUST014', 'COL009', '2024-12-20', 'Active', 'Low', 45000, '2024-12-10', '2025-01-21 13:45:00', '2025-01-26'),
('ACC015', 'CUST015', 'COL010', '2024-11-10', 'Active', 'Medium', 1350000, '2024-10-20', '2025-01-20 14:30:00', '2025-01-27'),
('ACC016', 'CUST016', 'COL001', '2024-11-05', 'Active', 'Medium', 120000, '2024-10-10', '2025-01-19 15:00:00', '2025-01-28'),
('ACC017', 'CUST017', 'COL002', '2024-10-30', 'Active', 'High', 55000, '2024-09-15', '2025-01-18 16:15:00', '2025-01-29'),
('ACC018', 'CUST018', 'COL003', '2024-12-25', 'Active', 'Low', 95000, '2024-12-20', '2025-01-21 09:30:00', '2025-01-30'),
('ACC019', 'CUST019', 'COL004', '2024-09-15', 'Legal', 'Critical', 420000, '2024-08-01', '2025-01-17 10:45:00', '2025-01-31'),
('ACC020', 'CUST020', 'COL005', '2024-12-01', 'Active', 'Medium', 38000, '2024-11-15', '2025-01-20 11:30:00', '2025-02-01'),
-- Lower priority cases
('ACC021', 'CUST021', 'COL006', '2024-11-25', 'Active', 'Medium', 18000, '2024-10-30', '2025-01-19 12:00:00', '2025-01-25'),
('ACC022', 'CUST022', 'COL007', '2024-11-15', 'Active', 'Medium', 45000, '2024-10-25', '2025-01-20 13:15:00', '2025-01-26'),
('ACC023', 'CUST023', 'COL008', '2024-10-10', 'Active', 'High', 22000, '2024-09-05', '2025-01-18 14:30:00', '2025-01-27'),
('ACC024', 'CUST024', 'COL009', '2024-12-10', 'Active', 'Low', 58000, '2024-11-25', '2025-01-21 15:45:00', '2025-01-28'),
('ACC025', 'CUST025', 'COL010', '2024-08-20', 'Write-off Review', 'Critical', 15000, '2024-07-01', '2025-01-15 16:30:00', '2025-02-01'),
('ACC026', 'CUST026', 'COL001', '2024-11-20', 'Active', 'Medium', 48000, '2024-10-28', '2025-01-20 09:15:00', '2025-01-24'),
('ACC027', 'CUST027', 'COL002', '2024-12-15', 'Active', 'Low', 28000, '2024-12-08', '2025-01-21 10:00:00', '2025-01-25'),
('ACC028', 'CUST028', 'COL003', '2024-10-25', 'Active', 'High', 38000, '2024-09-20', '2025-01-19 11:30:00', '2025-01-26'),
('ACC029', 'CUST029', 'COL004', '2024-09-10', 'Legal', 'Critical', 20000, '2024-08-05', '2025-01-17 12:45:00', '2025-01-30'),
('ACC030', 'CUST030', 'COL005', '2024-11-15', 'Active', 'Medium', 62000, '2024-10-22', '2025-01-20 13:30:00', '2025-01-27');

-- =============================================
-- SECTION 6: COLLECTION ACTIVITIES
-- =============================================

-- Recent collection activities (last 30 days)
INSERT INTO collection_activities (case_id, account_id, collector_id, activity_type, activity_datetime,
    contact_person, contact_number, activity_result, promise_amount, promise_date, notes, next_action, next_action_date)
VALUES
-- January 2025 activities
(1, 'ACC001', 'COL001', 'Call', '2025-01-20 10:30:00', 'Ahmad Al-Rashid', '+966501234567', 'PTP Obtained', 25000, '2025-01-25', 
    'Customer agreed to pay partial amount after salary', 'Follow up on PTP', '2025-01-25'),
(1, 'ACC001', 'COL001', 'SMS', '2025-01-19 09:00:00', 'Ahmad Al-Rashid', '+966501234567', 'Delivered', NULL, NULL, 
    'Payment reminder SMS sent', 'Call customer', '2025-01-20'),
(2, 'ACC002', 'COL002', 'Call', '2025-01-19 14:15:00', 'Fatima Al-Zahrani', '+966502345678', 'No Answer', NULL, NULL, 
    'Multiple attempts, no response', 'Send SMS', '2025-01-20'),
(3, 'ACC003', 'COL003', 'Visit', '2025-01-18 09:00:00', 'Mohammed Al-Otaibi', '+966503456789', 'Customer Not Available', NULL, NULL, 
    'Neighbor confirmed customer still lives there', 'Legal Notice', '2025-01-22'),
(4, 'ACC004', 'COL001', 'Call', '2025-01-21 11:45:00', 'Norah Al-Harbi', '+966504567890', 'PTP Obtained', 10000, '2025-01-28', 
    'Customer facing temporary financial difficulty', 'Follow up', '2025-01-28'),
(5, 'ACC005', 'COL004', 'Legal Notice', '2025-01-15 16:00:00', 'Khalid Al-Maliki', '+966505678901', 'Served', NULL, NULL, 
    'Legal notice served by court officer', 'Await response', '2025-01-30'),
(6, 'ACC006', 'COL002', 'Call', '2025-01-20 15:30:00', 'Aisha Al-Dosari', '+966506789012', 'Discussed', 100000, '2025-01-30', 
    'Business facing cash flow issues, negotiating payment plan', 'Follow up', '2025-01-30'),
(7, 'ACC007', 'COL003', 'Email', '2025-01-19 10:00:00', 'Abdullah Al-Ghamdi', 'abdullah.ghamdi@email.com', 'Sent', NULL, NULL, 
    'Detailed payment options sent via email', 'Call customer', '2025-01-21'),
(8, 'ACC008', 'COL004', 'Call', '2025-01-21 14:00:00', 'Maryam Al-Shehri', '+966508901234', 'PTP Obtained', 20000, '2025-01-26', 
    'Customer will pay after business income', 'Confirm payment', '2025-01-26'),
(9, 'ACC009', 'COL005', 'Visit', '2025-01-18 11:00:00', 'Faisal Al-Anazi', '+966509012345', 'Met Customer', 150000, '2025-02-05', 
    'Customer agreed to large payment after property sale', 'Document agreement', '2025-01-22'),
(10, 'ACC010', 'COL001', 'Call', '2025-01-17 09:30:00', 'Sara Al-Mutairi', '+966500123456', 'Disputed', NULL, NULL, 
    'Customer disputes the amount, requesting statement', 'Send statement', '2025-01-18'),
-- Additional activities for other cases
(11, 'ACC011', 'COL006', 'Call', '2025-01-20 09:00:00', 'Omar Al-Qahtani', '+966511111111', 'PTP Obtained', 15000, '2025-01-27', 
    'Will pay from end of service benefits', 'Follow up', '2025-01-27'),
(12, 'ACC012', 'COL007', 'SMS', '2025-01-21 10:30:00', 'Layla Al-Shammari', '+966512222222', 'Delivered', NULL, NULL, 
    'Reminder sent for overdue payment', 'Call customer', '2025-01-22'),
(13, 'ACC013', 'COL008', 'Visit', '2025-01-19 11:15:00', 'Yousef Al-Enezi', '+966513333333', 'Met Customer', 50000, '2025-01-31', 
    'Business owner promised payment after receivables', 'Follow up', '2025-01-31'),
(14, 'ACC014', 'COL009', 'Call', '2025-01-21 13:45:00', 'Huda Al-Dossari', '+966514444444', 'PTP Obtained', 8000, '2025-01-25', 
    'Partial payment promised', 'Confirm payment', '2025-01-25'),
(15, 'ACC015', 'COL010', 'Email', '2025-01-20 14:30:00', 'Turki Al-Subaie', 'turki.subaie@email.com', 'Sent', NULL, NULL, 
    'Settlement proposal sent', 'Await response', '2025-01-23'),
-- Historical activities (December 2024)
(1, 'ACC001', 'COL001', 'Call', '2024-12-15 10:00:00', 'Ahmad Al-Rashid', '+966501234567', 'PTP Obtained', 20000, '2024-12-20', 
    'Previous promise', 'Follow up', '2024-12-20'),
(1, 'ACC001', 'COL001', 'Call', '2024-12-20 14:30:00', 'Ahmad Al-Rashid', '+966501234567', 'Broken Promise', NULL, NULL, 
    'Customer did not keep promise', 'Escalate', '2024-12-22'),
(2, 'ACC002', 'COL002', 'Visit', '2024-12-10 09:00:00', 'Fatima Al-Zahrani', '+966502345678', 'Met Customer', 5000, '2024-12-15', 
    'Partial payment collected at door', 'Issue receipt', '2024-12-11'),
(3, 'ACC003', 'COL003', 'Call', '2024-12-05 11:00:00', 'Mohammed Al-Otaibi', '+966503456789', 'No Answer', NULL, NULL, 
    'Phone switched off', 'Try alternate number', '2024-12-06'),
(4, 'ACC004', 'COL001', 'SMS', '2024-12-18 08:00:00', 'Norah Al-Harbi', '+966504567890', 'Delivered', NULL, NULL, 
    'Balance reminder sent', 'Call customer', '2024-12-19');

-- =============================================
-- SECTION 7: PROMISE TO PAY (PTP)
-- =============================================

INSERT INTO promise_to_pay (case_id, account_id, customer_id, collector_id, promise_amount, 
    promise_date, ptp_status, actual_payment_amount, actual_payment_date, kept_flag)
VALUES
-- Active PTPs
(1, 'ACC001', 'CUST001', 'COL001', 25000, '2025-01-25', 'Active', NULL, NULL, false),
(4, 'ACC004', 'CUST004', 'COL001', 10000, '2025-01-28', 'Active', NULL, NULL, false),
(6, 'ACC006', 'CUST006', 'COL002', 100000, '2025-01-30', 'Active', NULL, NULL, false),
(8, 'ACC008', 'CUST008', 'COL004', 20000, '2025-01-26', 'Active', NULL, NULL, false),
(9, 'ACC009', 'CUST009', 'COL005', 150000, '2025-02-05', 'Active', NULL, NULL, false),
(11, 'ACC011', 'CUST011', 'COL006', 15000, '2025-01-27', 'Active', NULL, NULL, false),
(13, 'ACC013', 'CUST013', 'COL008', 50000, '2025-01-31', 'Active', NULL, NULL, false),
(14, 'ACC014', 'CUST014', 'COL009', 8000, '2025-01-25', 'Active', NULL, NULL, false),
-- Historical PTPs (Kept)
(1, 'ACC001', 'CUST001', 'COL001', 15000, '2024-11-30', 'Kept', 15000, '2024-11-30', true),
(2, 'ACC002', 'CUST002', 'COL002', 5000, '2024-12-10', 'Kept', 5000, '2024-12-10', true),
(7, 'ACC007', 'CUST007', 'COL003', 30000, '2024-12-05', 'Kept', 30000, '2024-12-05', true),
(8, 'ACC008', 'CUST008', 'COL004', 10000, '2024-12-15', 'Kept', 10000, '2024-12-15', true),
(11, 'ACC011', 'CUST011', 'COL006', 12000, '2024-11-25', 'Kept', 12000, '2024-11-25', true),
(16, 'ACC016', 'CUST016', 'COL001', 18000, '2024-12-01', 'Kept', 18000, '2024-12-01', true),
-- Historical PTPs (Broken)
(1, 'ACC001', 'CUST001', 'COL001', 20000, '2024-12-20', 'Broken', 0, NULL, false),
(3, 'ACC003', 'CUST003', 'COL003', 100000, '2024-11-15', 'Broken', 0, NULL, false),
(5, 'ACC005', 'CUST005', 'COL004', 5000, '2024-10-30', 'Broken', 0, NULL, false),
(10, 'ACC010', 'CUST010', 'COL001', 8000, '2024-11-20', 'Broken', 0, NULL, false),
(12, 'ACC012', 'CUST012', 'COL007', 3000, '2024-12-08', 'Broken', 0, NULL, false),
-- Historical PTPs (Partial)
(2, 'ACC002', 'CUST002', 'COL002', 10000, '2024-11-28', 'Partial', 6000, '2024-11-30', false),
(6, 'ACC006', 'CUST006', 'COL002', 80000, '2024-11-20', 'Partial', 50000, '2024-11-22', false),
(9, 'ACC009', 'CUST009', 'COL005', 100000, '2024-10-31', 'Partial', 70000, '2024-11-05', false);

-- =============================================
-- SECTION 8: PAYMENT TRANSACTIONS
-- =============================================

INSERT INTO payment_transactions (account_id, customer_id, payment_date, payment_amount, 
    payment_method, payment_channel, receipt_number, collected_by, allocation_type, 
    principal_paid, profit_paid, late_fee_paid, transaction_status)
VALUES
-- Recent payments (January 2025)
('ACC008', 'CUST008', '2025-01-15', 10000, 'Bank Transfer', 'Online Banking', 'ONL20250115001', 'System', 'Auto', 9000, 1000, 0, 'Completed'),
('ACC014', 'CUST014', '2025-01-10', 5000, 'Cash', 'Branch', 'BR20250110001', 'Branch Staff', 'Manual', 4500, 500, 0, 'Completed'),
('ACC018', 'CUST018', '2025-01-08', 8000, 'Debit Card', 'ATM', 'ATM20250108001', 'System', 'Auto', 7200, 800, 0, 'Completed'),
('ACC027', 'CUST027', '2025-01-05', 3000, 'Mobile Transfer', 'Mobile App', 'MOB20250105001', 'System', 'Auto', 2700, 300, 0, 'Completed'),
-- December 2024 payments
('ACC001', 'CUST001', '2024-12-02', 15000, 'Cash', 'Field Collection', 'FLD20241202001', 'COL001', 'Manual', 13500, 1500, 0, 'Completed'),
('ACC002', 'CUST002', '2024-12-10', 5000, 'Bank Transfer', 'Online', 'ONL20241210001', 'System', 'Auto', 4500, 500, 0, 'Completed'),
('ACC004', 'CUST004', '2024-11-30', 8000, 'Debit Card', 'POS', 'POS20241130001', 'Branch Staff', 'Manual', 7200, 800, 0, 'Completed'),
('ACC007', 'CUST007', '2024-12-05', 30000, 'Bank Transfer', 'Mobile App', 'MOB20241205001', 'System', 'Auto', 27000, 3000, 0, 'Completed'),
('ACC008', 'CUST008', '2024-12-15', 10000, 'Online Transfer', 'Internet Banking', 'ONL20241215001', 'System', 'Auto', 9000, 1000, 0, 'Completed'),
('ACC011', 'CUST011', '2024-11-25', 12000, 'Cheque', 'Branch', 'CHQ20241125001', 'Branch Staff', 'Manual', 10800, 1200, 0, 'Completed'),
('ACC016', 'CUST016', '2024-12-01', 18000, 'Cash', 'Branch', 'BR20241201001', 'Branch Staff', 'Manual', 16200, 1800, 0, 'Completed'),
-- November 2024 payments
('ACC001', 'CUST001', '2024-11-30', 15000, 'Bank Transfer', 'Online', 'ONL20241130002', 'System', 'Auto', 13500, 1500, 0, 'Completed'),
('ACC002', 'CUST002', '2024-11-30', 6000, 'Cash', 'Field Collection', 'FLD20241130001', 'COL002', 'Manual', 5400, 600, 0, 'Completed'),
('ACC003', 'CUST003', '2024-08-10', 50000, 'Cheque', 'Branch', 'CHQ20240810001', 'Branch Staff', 'Manual', 45000, 5000, 0, 'Completed'),
('ACC006', 'CUST006', '2024-11-22', 50000, 'Bank Transfer', 'Corporate Banking', 'CORP20241122001', 'System', 'Auto', 45000, 5000, 0, 'Completed'),
('ACC009', 'CUST009', '2024-11-05', 70000, 'Bank Transfer', 'Online', 'ONL20241105001', 'System', 'Auto', 63000, 7000, 0, 'Completed'),
-- October 2024 payments
('ACC012', 'CUST012', '2024-10-20', 3500, 'Cash', 'Branch', 'BR20241020001', 'Branch Staff', 'Manual', 3150, 350, 0, 'Completed'),
('ACC015', 'CUST015', '2024-10-15', 45000, 'Bank Transfer', 'Online', 'ONL20241015001', 'System', 'Auto', 40500, 4500, 0, 'Completed'),
('ACC017', 'CUST017', '2024-09-15', 8000, 'Mobile Transfer', 'Mobile App', 'MOB20240915001', 'System', 'Auto', 7200, 800, 0, 'Completed'),
('ACC020', 'CUST020', '2024-11-15', 4000, 'Cash', 'Field Collection', 'FLD20241115001', 'COL005', 'Manual', 3600, 400, 0, 'Completed'),
('ACC022', 'CUST022', '2024-10-25', 5500, 'Debit Card', 'ATM', 'ATM20241025001', 'System', 'Auto', 4950, 550, 0, 'Completed');

-- =============================================
-- SECTION 9: LEGAL CASES
-- =============================================

INSERT INTO legal_cases (account_id, customer_id, case_type, court_name, case_number, 
    filing_date, lawyer_name, case_status, judgment_date, judgment_amount, legal_costs, next_hearing_date)
VALUES
('ACC003', 'CUST003', 'Execution', 'Riyadh General Court', 'EX2024/1234', '2024-10-15', 
    'Abdullah Legal Firm', 'Under Execution', '2024-12-20', 950000, 25000, '2025-02-15'),
('ACC005', 'CUST005', 'Civil Case', 'Jeddah General Court', 'CV2024/5678', '2024-08-20', 
    'Al-Fahad Law Office', 'Judgment Obtained', '2024-11-15', 48000, 8000, NULL),
('ACC010', 'CUST010', 'Civil Case', 'Dammam General Court', 'CV2024/9012', '2024-09-10', 
    'Al-Rashid Legal Consultants', 'Filed', NULL, NULL, 5000, '2025-02-10'),
('ACC019', 'CUST019', 'Execution', 'Riyadh Commercial Court', 'EX2024/3456', '2024-09-25', 
    'Al-Subaie Law Firm', 'Under Execution', '2024-12-01', 420000, 15000, '2025-03-01'),
('ACC029', 'CUST029', 'Civil Case', 'Makkah General Court', 'CV2024/7890', '2024-09-15', 
    'Al-Harbi Legal Services', 'In Progress', NULL, NULL, 3000, '2025-02-20'),
('ACC025', 'CUST025', 'Execution', 'Jeddah General Court', 'EX2024/2345', '2024-08-30', 
    'Al-Zahrani Advocates', 'Judgment Obtained', '2024-11-30', 15000, 2500, NULL),
('ACC037', 'CUST037', 'Civil Case', 'Madinah General Court', 'CV2024/6789', '2024-10-05', 
    'Al-Otaibi Law Office', 'Filed', NULL, NULL, 6000, '2025-02-25'),
('ACC040', 'CUST040', 'Civil Case', 'Riyadh General Court', 'CV2024/4567', '2024-11-01', 
    'Al-Ghamdi Legal Firm', 'In Progress', NULL, NULL, 2000, '2025-03-05');

-- =============================================
-- SECTION 10: SETTLEMENTS
-- =============================================

INSERT INTO settlements (account_id, customer_id, original_outstanding, settlement_amount, 
    discount_amount, discount_percentage, approval_level, approved_by, approval_date, 
    settlement_status, payment_plan)
VALUES
-- Approved settlements
('ACC015', 'CUST015', 1350000, 1080000, 270000, 20.0, 'Senior Management', 'MGR001', '2024-11-01', 'Approved', 'Installment'),
('ACC006', 'CUST006', 580000, 493000, 87000, 15.0, 'Department Head', 'HEAD001', '2024-10-15', 'Approved', 'Lump Sum'),
('ACC011', 'CUST011', 85000, 76500, 8500, 10.0, 'Team Leader', 'TL001', '2024-12-01', 'Approved', 'Installment'),
-- Pending settlements
('ACC013', 'CUST013', 350000, 280000, 70000, 20.0, 'Senior Management', NULL, NULL, 'Pending', 'Installment'),
('ACC019', 'CUST019', 420000, 357000, 63000, 15.0, 'Department Head', NULL, NULL, 'Pending', 'Lump Sum'),
-- Rejected settlements
('ACC003', 'CUST003', 950000, 475000, 475000, 50.0, 'CEO', 'CEO001', '2024-10-20', 'Rejected', 'Lump Sum'),
('ACC009', 'CUST009', 720000, 432000, 288000, 40.0, 'Senior Management', 'MGR001', '2024-11-15', 'Rejected', 'Installment'),
-- Completed settlements
('ACC017', 'CUST017', 55000, 46750, 8250, 15.0, 'Team Leader', 'TL002', '2024-09-15', 'Completed', 'Lump Sum'),
('ACC022', 'CUST022', 45000, 40500, 4500, 10.0, 'Team Leader', 'TL001', '2024-10-01', 'Completed', 'Installment');

-- =============================================
-- SECTION 11: ASSET RECOVERY
-- =============================================

INSERT INTO asset_recovery (account_id, asset_type, asset_description, repossession_date, 
    storage_location, estimated_value, auction_date, sale_amount, recovery_costs, net_recovery, recovery_status)
VALUES
('ACC001', 'Vehicle', '2021 Toyota Camry - White', '2024-11-15', 'Riyadh Storage Yard A', 85000, '2024-12-20', 78000, 5000, 73000, 'Sold'),
('ACC004', 'Vehicle', '2022 Honda Accord - Black', '2024-12-10', 'Riyadh Storage Yard B', 95000, NULL, NULL, 3000, NULL, 'In Storage'),
('ACC007', 'Vehicle', '2021 Nissan Altima - Silver', '2024-11-20', 'Jeddah Storage Facility', 70000, '2024-12-15', 65000, 4000, 61000, 'Sold'),
('ACC011', 'Vehicle', '2022 Mazda CX-5 - Red', '2024-12-05', 'Riyadh Storage Yard A', 80000, NULL, NULL, 2500, NULL, 'In Storage'),
('ACC016', 'Vehicle', '2021 Ford Explorer - Blue', '2024-11-25', 'Dammam Storage Center', 110000, '2025-01-15', NULL, 3500, NULL, 'Scheduled for Auction'),
('ACC022', 'Vehicle', '2020 Hyundai Elantra - Gray', '2024-10-20', 'Riyadh Storage Yard B', 45000, '2024-11-25', 41000, 2000, 39000, 'Sold'),
('ACC026', 'Vehicle', '2021 Kia Sportage - White', '2024-11-30', 'Riyadh Storage Yard A', 65000, '2025-01-20', NULL, 2000, NULL, 'Scheduled for Auction'),
('ACC030', 'Vehicle', '2022 Chevrolet Malibu - Black', '2024-12-15', 'Jeddah Storage Facility', 75000, NULL, NULL, 2500, NULL, 'In Storage');

-- =============================================
-- SECTION 12: COLLECTOR PERFORMANCE
-- =============================================

INSERT INTO collector_performance (collector_id, performance_date, assigned_cases, contacted_cases, 
    collected_amount, target_amount, ptp_obtained, ptp_kept, calls_made, visits_made, success_rate)
VALUES
-- January 2025 performance
('COL001', '2025-01-21', 28, 25, 155000, 180000, 10, 7, 95, 6, 86.11),
('COL002', '2025-01-21', 22, 20, 115000, 150000, 7, 5, 82, 4, 76.67),
('COL003', '2025-01-21', 32, 28, 195000, 220000, 12, 9, 118, 9, 88.64),
('COL004', '2025-01-21', 25, 23, 95000, 120000, 6, 4, 98, 5, 79.17),
('COL005', '2025-01-21', 30, 28, 225000, 250000, 14, 11, 112, 11, 90.00),
('COL006', '2025-01-21', 20, 18, 85000, 110000, 5, 3, 75, 3, 77.27),
('COL007', '2025-01-21', 18, 16, 65000, 90000, 4, 2, 68, 2, 72.22),
('COL008', '2025-01-21', 24, 22, 105000, 130000, 8, 6, 88, 6, 80.77),
('COL009', '2025-01-21', 26, 24, 125000, 140000, 9, 7, 92, 7, 89.29),
('COL010', '2025-01-21', 21, 19, 95000, 115000, 6, 4, 78, 4, 82.61),
-- December 2024 performance
('COL001', '2024-12-31', 26, 24, 145000, 170000, 9, 7, 88, 5, 85.29),
('COL002', '2024-12-31', 20, 18, 105000, 140000, 6, 4, 76, 3, 75.00),
('COL003', '2024-12-31', 30, 27, 185000, 210000, 11, 8, 108, 8, 88.10),
('COL004', '2024-12-31', 23, 21, 88000, 115000, 5, 3, 92, 4, 76.52),
('COL005', '2024-12-31', 28, 26, 210000, 240000, 13, 10, 104, 10, 87.50);

-- =============================================
-- SECTION 13: SHARIA COMPLIANCE
-- =============================================

INSERT INTO sharia_compliance (account_id, compliance_type, late_payment_charges, charity_amount,
    charity_paid_date, profit_purification, compliance_status, reviewed_by, review_date, notes)
VALUES
('ACC001', 'Late Payment Charges', 2500, 2500, '2024-12-15', 0, 'Compliant', 'Sharia Board', '2024-12-14', 
    'Late payment charges donated to approved charity - Ehsan Platform'),
('ACC003', 'Profit Purification', 0, 0, NULL, 15000, 'Under Review', 'Sharia Auditor', '2025-01-20', 
    'Reviewing profit calculation for compliance with Islamic finance principles'),
('ACC005', 'Late Payment Charges', 1800, 1800, '2024-12-10', 0, 'Compliant', 'Sharia Board', '2024-12-09', 
    'All late fees transferred to charity account'),
('ACC006', 'Late Payment Charges', 3200, 3200, '2024-11-30', 0, 'Compliant', 'Sharia Board', '2024-11-29', 
    'Donated to King Salman Humanitarian Aid'),
('ACC009', 'Profit Purification', 0, 0, NULL, 8500, 'Under Review', 'Sharia Auditor', '2025-01-15', 
    'Quarterly review of profit calculations'),
('ACC010', 'Late Payment Charges', 1500, 1500, '2024-12-20', 0, 'Compliant', 'Sharia Board', '2024-12-19', 
    'Transferred to Zakat and Income Tax Authority charity fund'),
('ACC013', 'Late Payment Charges', 4500, 4500, '2024-11-25', 0, 'Compliant', 'Sharia Board', '2024-11-24', 
    'Donated to local orphanage'),
('ACC015', 'Profit Purification', 0, 0, NULL, 25000, 'Approved', 'Sharia Committee', '2024-12-01', 
    'Annual profit purification completed'),
('ACC019', 'Late Payment Charges', 5800, 5800, '2024-12-05', 0, 'Compliant', 'Sharia Board', '2024-12-04', 
    'Charity payment processed through Ehsan'),
('ACC023', 'Late Payment Charges', 950, 950, '2025-01-10', 0, 'Compliant', 'Sharia Board', '2025-01-09', 
    'Monthly charity transfer completed');

-- =============================================
-- SECTION 14: PAYMENT SCHEDULE (Sample for few accounts)
-- =============================================

-- Payment schedule for ACC001 (showing last 6 months and next 6 months)
INSERT INTO payment_schedule (account_id, installment_no, due_date, principal_amount, 
    profit_amount, total_amount, paid_amount, payment_date, payment_status, dpd)
VALUES
-- Past due installments
('ACC001', 55, '2024-08-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 159),
('ACC001', 56, '2024-09-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 128),
('ACC001', 57, '2024-10-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 98),
('ACC001', 58, '2024-11-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 67),
('ACC001', 59, '2024-12-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 37),
('ACC001', 60, '2025-01-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Overdue', 6),
-- Future installments
('ACC001', 61, '2025-02-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0),
('ACC001', 62, '2025-03-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0),
('ACC001', 63, '2025-04-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0),
('ACC001', 64, '2025-05-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0),
('ACC001', 65, '2025-06-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0),
('ACC001', 66, '2025-07-15', 3750.00, 937.50, 4687.50, 0, NULL, 'Pending', 0);

-- =============================================
-- END OF SAMPLE DATA
-- =============================================

-- Note: This script provides comprehensive sample data for all collection-related tables
-- The data represents realistic scenarios including:
-- - Various customer profiles (high-income to low-income)
-- - Different product types (Auto, Personal, Home, SME Finance)
-- - Multiple delinquency buckets
-- - Active collection cases with different priorities
-- - Collection activities (calls, visits, SMS, emails, legal notices)
-- - Promise to pay records (kept, broken, partial)
-- - Payment transactions across different channels
-- - Legal cases in various stages
-- - Settlement proposals and approvals
-- - Asset recovery processes
-- - Collector performance metrics
-- - Sharia compliance tracking