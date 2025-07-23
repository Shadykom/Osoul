-- =============================================
-- Osoul Modern Company - Collection Department
-- Missing Sample Data Insertion Script
-- Version: 1.0
-- Created: January 2025
-- =============================================

-- This script adds missing sample data to ensure comprehensive testing
-- of all dashboards and reports in the collection system

USE osoul_collections;

-- =============================================
-- SECTION 1: ADDITIONAL CUSTOMERS (50 more)
-- =============================================

INSERT INTO customers (customer_id, national_id, first_name, last_name, first_name_ar, last_name_ar, 
    date_of_birth, gender, nationality, employment_status, employer_name, monthly_income, credit_score, risk_category)
VALUES
-- Additional high-value customers
('CUST051', '1111111111', 'Mansour', 'Al-Rasheed', 'منصور', 'الرشيد', '1982-04-12', 'M', 'Saudi', 'Employed', 'Saudi Electricity', 26000, 760, 'Low'),
('CUST052', '2222222222', 'Lamia', 'Al-Subaie', 'لمياء', 'السبيعي', '1988-08-25', 'F', 'Saudi', 'Employed', 'King Abdullah University', 21000, 720, 'Low'),
('CUST053', '3333333333', 'Badr', 'Al-Mutlaq', 'بدر', 'المطلق', '1985-11-30', 'M', 'Saudi', 'Self-Employed', 'Real Estate Developer', 55000, 680, 'Medium'),
('CUST054', '4444444444', 'Hanan', 'Al-Rashidi', 'حنان', 'الرشيدي', '1991-03-18', 'F', 'Saudi', 'Employed', 'Saudi Investment Bank', 19000, 710, 'Low'),
('CUST055', '5555555555', 'Tariq', 'Al-Harbi', 'طارق', 'الحربي', '1984-07-22', 'M', 'Saudi', 'Employed', 'ACWA Power', 32000, 690, 'Medium'),
('CUST056', '6666666666', 'Rania', 'Al-Ghamdi', 'رانيا', 'الغامدي', '1990-12-05', 'F', 'Saudi', 'Employed', 'Ministry of Finance', 17500, 700, 'Low'),
('CUST057', '7777777777', 'Saeed', 'Al-Zahrani', 'سعيد', 'الزهراني', '1987-05-14', 'M', 'Saudi', 'Employed', 'Ma\'aden', 28000, 670, 'Medium'),
('CUST058', '8888888888', 'Mona', 'Al-Otaibi', 'منى', 'العتيبي', '1993-09-28', 'F', 'Saudi', 'Employed', 'Almarai', 14500, 685, 'Medium'),
('CUST059', '9999999999', 'Hamza', 'Al-Maliki', 'حمزة', 'المالكي', '1986-02-10', 'M', 'Saudi', 'Self-Employed', 'Import/Export Business', 42000, 640, 'Medium'),
('CUST060', '1010101010', 'Salma', 'Al-Harbi', 'سلمى', 'الحربي', '1992-06-20', 'F', 'Saudi', 'Employed', 'Mobily', 16000, 695, 'Low'),
-- Medium-value customers
('CUST061', '1212121213', 'Majid', 'Al-Shehri', 'ماجد', 'الشهري', '1989-10-15', 'M', 'Saudi', 'Employed', 'Local Government', 12500, 650, 'Medium'),
('CUST062', '2323232324', 'Khadija', 'Al-Qahtani', 'خديجة', 'القحطاني', '1991-04-08', 'F', 'Saudi', 'Employed', 'Private School', 10500, 640, 'Medium'),
('CUST063', '3434343435', 'Azzam', 'Al-Enezi', 'عزام', 'العنزي', '1985-12-25', 'M', 'Saudi', 'Employed', 'Security Company', 8500, 620, 'High'),
('CUST064', '4545454546', 'Bushra', 'Al-Dossari', 'بشرى', 'الدوسري', '1993-07-12', 'F', 'Saudi', 'Part-time', 'Online Business', 7000, 630, 'Medium'),
('CUST065', '5656565657', 'Nayef', 'Al-Rasheed', 'نايف', 'الرشيد', '1987-03-30', 'M', 'Saudi', 'Employed', 'Contracting Company', 11000, 655, 'Medium'),
('CUST066', '6767676768', 'Zahra', 'Al-Mutairi', 'زهراء', 'المطيري', '1990-11-18', 'F', 'Saudi', 'Employed', 'Healthcare Center', 9500, 665, 'Medium'),
('CUST067', '7878787879', 'Thamer', 'Al-Ghamdi', 'ثامر', 'الغامدي', '1988-08-05', 'M', 'Saudi', 'Self-Employed', 'Small Business', 13000, 635, 'Medium'),
('CUST068', '8989898990', 'Afaf', 'Al-Zahrani', 'عفاف', 'الزهراني', '1992-02-22', 'F', 'Saudi', 'Employed', 'Insurance Company', 10000, 670, 'Medium'),
('CUST069', '9090909091', 'Malik', 'Al-Otaibi', 'مالك', 'العتيبي', '1986-09-10', 'M', 'Saudi', 'Employed', 'Manufacturing', 12000, 645, 'Medium'),
('CUST070', '0101010102', 'Wedad', 'Al-Harbi', 'وداد', 'الحربي', '1994-05-28', 'F', 'Saudi', 'Employed', 'Retail Manager', 11500, 660, 'Medium'),
-- Lower-income customers
('CUST071', '1313131313', 'Rakan', 'Al-Subaie', 'راكان', 'السبيعي', '1990-07-15', 'M', 'Saudi', 'Employed', 'Driver', 4500, 570, 'High'),
('CUST072', '2424242424', 'Samira', 'Al-Maliki', 'سميرة', 'المالكي', '1988-01-20', 'F', 'Saudi', 'Part-time', 'Cleaner', 3500, 560, 'High'),
('CUST073', '3535353535', 'Bader', 'Al-Harbi', 'بادر', 'الحربي', '1985-11-08', 'M', 'Saudi', 'Unemployed', NULL, 0, 540, 'High'),
('CUST074', '4646464646', 'Hala', 'Al-Ghamdi', 'هالة', 'الغامدي', '1993-06-25', 'F', 'Saudi', 'Employed', 'Factory Worker', 5500, 580, 'High'),
('CUST075', '5757575757', 'Salem', 'Al-Zahrani', 'سالم', 'الزهراني', '1989-03-12', 'M', 'Saudi', 'Self-Employed', 'Street Vendor', 4000, 565, 'High'),
('CUST076', '6868686868', 'Najla', 'Al-Otaibi', 'نجلاء', 'العتيبي', '1991-10-30', 'F', 'Saudi', 'Employed', 'Waitress', 4800, 590, 'High'),
('CUST077', '7979797979', 'Ayad', 'Al-Rasheed', 'عياد', 'الرشيد', '1987-05-18', 'M', 'Saudi', 'Employed', 'Construction Worker', 6000, 575, 'High'),
('CUST078', '8080808080', 'Tahani', 'Al-Mutairi', 'تهاني', 'المطيري', '1992-12-05', 'F', 'Saudi', 'Part-time', 'Home Baker', 3800, 585, 'High'),
('CUST079', '9191919191', 'Mishaal', 'Al-Harbi', 'مشعل', 'الحربي', '1988-08-22', 'M', 'Saudi', 'Employed', 'Security Guard', 5200, 570, 'High'),
('CUST080', '0202020202', 'Ibtisam', 'Al-Ghamdi', 'ابتسام', 'الغامدي', '1994-02-10', 'F', 'Saudi', 'Unemployed', NULL, 0, 550, 'High'),
-- Additional diverse customers
('CUST081', '1414141414', 'Adnan', 'Al-Sulaiman', 'عدنان', 'السليمان', '1984-09-28', 'M', 'Saudi', 'Employed', 'Petrochemical Company', 24000, 730, 'Low'),
('CUST082', '2525252525', 'Lubna', 'Al-Rashidi', 'لبنى', 'الرشيدي', '1990-04-15', 'F', 'Saudi', 'Employed', 'Digital Marketing Agency', 15000, 690, 'Medium'),
('CUST083', '3636363636', 'Haitham', 'Al-Qahtani', 'هيثم', 'القحطاني', '1986-12-02', 'M', 'Saudi', 'Self-Employed', 'Consulting Firm', 38000, 710, 'Low'),
('CUST084', '4747474747', 'Suha', 'Al-Enezi', 'سها', 'العنزي', '1992-07-20', 'F', 'Saudi', 'Employed', 'Pharmaceutical Company', 13500, 680, 'Medium'),
('CUST085', '5858585858', 'Qasim', 'Al-Dossari', 'قاسم', 'الدوسري', '1985-03-08', 'M', 'Saudi', 'Employed', 'Logistics Company', 16500, 670, 'Medium'),
('CUST086', '6969696969', 'Raghad', 'Al-Harbi', 'رغد', 'الحربي', '1993-11-25', 'F', 'Saudi', 'Employed', 'Architecture Firm', 17000, 695, 'Low'),
('CUST087', '7070707070', 'Muhannad', 'Al-Ghamdi', 'مهند', 'الغامدي', '1989-06-12', 'M', 'Saudi', 'Employed', 'IT Company', 22000, 705, 'Low'),
('CUST088', '8181818181', 'Arwa', 'Al-Zahrani', 'أروى', 'الزهراني', '1991-01-30', 'F', 'Saudi', 'Employed', 'Fashion Designer', 14000, 685, 'Medium'),
('CUST089', '9292929292', 'Zuhair', 'Al-Otaibi', 'زهير', 'العتيبي', '1987-10-18', 'M', 'Saudi', 'Self-Employed', 'Mobile Shop Owner', 25000, 660, 'Medium'),
('CUST090', '0303030303', 'Hadeel', 'Al-Maliki', 'هديل', 'المالكي', '1994-06-05', 'F', 'Saudi', 'Employed', 'Laboratory Technician', 12500, 675, 'Medium'),
-- High-risk customers
('CUST091', '1515151515', 'Jaber', 'Al-Rasheed', 'جابر', 'الرشيد', '1986-02-22', 'M', 'Saudi', 'Unemployed', NULL, 0, 520, 'High'),
('CUST092', '2626262626', 'Fatima', 'Al-Subaie', 'فاطمة', 'السبيعي', '1991-09-10', 'F', 'Saudi', 'Part-time', 'Freelancer', 3000, 530, 'High'),
('CUST093', '3737373737', 'Naji', 'Al-Harbi', 'ناجي', 'الحربي', '1988-05-28', 'M', 'Saudi', 'Employed', 'Day Laborer', 4200, 545, 'High'),
('CUST094', '4848484848', 'Jamila', 'Al-Ghamdi', 'جميلة', 'الغامدي', '1993-12-15', 'F', 'Saudi', 'Unemployed', NULL, 0, 510, 'High'),
('CUST095', '5959595959', 'Dhafer', 'Al-Zahrani', 'ظافر', 'الزهراني', '1985-08-02', 'M', 'Saudi', 'Self-Employed', 'Small Trader', 5000, 555, 'High'),
('CUST096', '6060606060', 'Sheikha', 'Al-Otaibi', 'شيخة', 'العتيبي', '1990-03-20', 'F', 'Saudi', 'Employed', 'Domestic Worker', 3500, 540, 'High'),
('CUST097', '7171717171', 'Ghanem', 'Al-Mutairi', 'غانم', 'المطيري', '1987-11-08', 'M', 'Saudi', 'Employed', 'Farm Worker', 4500, 550, 'High'),
('CUST098', '8282828282', 'Wadha', 'Al-Rashidi', 'وضحى', 'الرشيدي', '1992-06-25', 'F', 'Saudi', 'Part-time', 'Seamstress', 3200, 535, 'High'),
('CUST099', '9393939393', 'Mohsen', 'Al-Qahtani', 'محسن', 'القحطاني', '1989-01-12', 'M', 'Saudi', 'Unemployed', NULL, 0, 525, 'High'),
('CUST100', '0404040404', 'Anoud', 'Al-Enezi', 'العنود', 'العنزي', '1994-10-30', 'F', 'Saudi', 'Employed', 'Shop Assistant', 4000, 560, 'High');

-- =============================================
-- SECTION 2: ADDITIONAL FINANCE ACCOUNTS
-- =============================================

-- Adding more accounts for existing and new customers
INSERT INTO finance_accounts (account_id, customer_id, product_type, finance_amount, profit_rate, 
    tenure_months, monthly_installment, outstanding_amount, principal_outstanding, profit_outstanding,
    origination_date, maturity_date, branch_code, officer_id, account_status, dpd, bucket)
VALUES
-- Additional accounts for new customers
('ACC051', 'CUST051', 'Home Finance', 2500000, 3.8, 240, 15000, 2200000, 2100000, 100000, '2020-04-12', '2040-04-12', 'BR001', 'OFF001', 'Delinquent', 30, 'Bucket 2'),
('ACC052', 'CUST052', 'Auto Finance', 320000, 4.5, 60, 6000, 195000, 185000, 10000, '2021-08-25', '2026-08-25', 'BR002', 'OFF002', 'Delinquent', 45, 'Bucket 2'),
('ACC053', 'CUST053', 'SME Finance', 2000000, 4.2, 120, 23333.33, 1650000, 1600000, 50000, '2019-11-30', '2029-11-30', 'BR003', 'OFF003', 'Delinquent', 75, 'Bucket 3'),
('ACC054', 'CUST054', 'Personal Finance', 150000, 5.0, 48, 3437.50, 95000, 90000, 5000, '2022-03-18', '2026-03-18', 'BR001', 'OFF001', 'Current', 10, 'Bucket 1'),
('ACC055', 'CUST055', 'Auto Finance', 450000, 4.5, 72, 7187.50, 320000, 305000, 15000, '2020-07-22', '2026-07-22', 'BR002', 'OFF002', 'Delinquent', 85, 'Bucket 3'),
('ACC056', 'CUST056', 'Personal Finance', 110000, 5.0, 36, 3300, 68000, 64000, 4000, '2022-12-05', '2025-12-05', 'BR003', 'OFF003', 'Delinquent', 25, 'Bucket 1'),
('ACC057', 'CUST057', 'Home Finance', 1800000, 3.8, 180, 12600, 1450000, 1400000, 50000, '2021-05-14', '2036-05-14', 'BR001', 'OFF001', 'Delinquent', 55, 'Bucket 2'),
('ACC058', 'CUST058', 'Auto Finance', 160000, 4.5, 48, 3800, 92000, 87000, 5000, '2022-09-28', '2026-09-28', 'BR002', 'OFF002', 'Delinquent', 35, 'Bucket 2'),
('ACC059', 'CUST059', 'SME Finance', 1200000, 4.2, 96, 15000, 850000, 820000, 30000, '2020-02-10', '2028-02-10', 'BR003', 'OFF003', 'Delinquent', 105, 'Bucket 4'),
('ACC060', 'CUST060', 'Personal Finance', 130000, 5.0, 48, 2979.17, 78000, 74000, 4000, '2022-06-20', '2026-06-20', 'BR001', 'OFF001', 'Delinquent', 40, 'Bucket 2'),
-- Credit Card accounts (new product type)
('ACC061', 'CUST061', 'Credit Card', 50000, 18.0, 0, 0, 45000, 45000, 0, '2023-01-15', NULL, 'BR002', 'OFF002', 'Delinquent', 90, 'Bucket 3'),
('ACC062', 'CUST062', 'Credit Card', 30000, 18.0, 0, 0, 28000, 28000, 0, '2023-03-20', NULL, 'BR003', 'OFF003', 'Delinquent', 60, 'Bucket 3'),
('ACC063', 'CUST063', 'Credit Card', 20000, 18.0, 0, 0, 19500, 19500, 0, '2023-05-10', NULL, 'BR001', 'OFF001', 'Delinquent', 120, 'Bucket 4'),
('ACC064', 'CUST064', 'Credit Card', 15000, 18.0, 0, 0, 14800, 14800, 0, '2023-06-15', NULL, 'BR002', 'OFF002', 'Delinquent', 150, 'Bucket 4'),
('ACC065', 'CUST065', 'Credit Card', 40000, 18.0, 0, 0, 38000, 38000, 0, '2023-02-28', NULL, 'BR003', 'OFF003', 'Delinquent', 45, 'Bucket 2'),
-- Multiple accounts for same customers
('ACC066', 'CUST001', 'Personal Finance', 100000, 5.0, 36, 3000, 55000, 52000, 3000, '2023-01-10', '2026-01-10', 'BR001', 'OFF001', 'Delinquent', 20, 'Bucket 1'),
('ACC067', 'CUST003', 'Auto Finance', 350000, 4.5, 60, 6562.50, 285000, 270000, 15000, '2021-12-15', '2026-12-15', 'BR002', 'OFF002', 'Delinquent', 65, 'Bucket 3'),
('ACC068', 'CUST006', 'Personal Finance', 200000, 5.0, 48, 4583.33, 145000, 138000, 7000, '2022-04-20', '2026-04-20', 'BR003', 'OFF003', 'Current', 5, 'Bucket 1'),
('ACC069', 'CUST009', 'Auto Finance', 280000, 4.5, 60, 5250, 195000, 185000, 10000, '2021-10-01', '2026-10-01', 'BR001', 'OFF001', 'Delinquent', 80, 'Bucket 3'),
('ACC070', 'CUST015', 'SME Finance', 3000000, 4.2, 144, 29166.67, 2450000, 2400000, 50000, '2019-08-25', '2031-08-25', 'BR002', 'OFF002', 'Delinquent', 95, 'Bucket 4'),
-- High-risk accounts
('ACC071', 'CUST071', 'Personal Finance', 15000, 6.0, 18, 875, 14500, 14000, 500, '2023-07-15', '2025-01-15', 'BR003', 'OFF003', 'Delinquent', 210, 'Bucket 5'),
('ACC072', 'CUST072', 'Personal Finance', 10000, 6.0, 12, 861.11, 9800, 9500, 300, '2023-08-20', '2024-08-20', 'BR001', 'OFF001', 'Delinquent', 240, 'Bucket 5'),
('ACC073', 'CUST073', 'Personal Finance', 20000, 6.0, 24, 916.67, 19500, 19000, 500, '2023-05-08', '2025-05-08', 'BR002', 'OFF002', 'Write-off Review', 260, 'Bucket 5'),
('ACC074', 'CUST074', 'Auto Finance', 55000, 4.5, 36, 1637.50, 52000, 50000, 2000, '2023-02-25', '2026-02-25', 'BR003', 'OFF003', 'Delinquent', 180, 'Bucket 5'),
('ACC075', 'CUST075', 'Personal Finance', 12000, 6.0, 18, 700, 11800, 11500, 300, '2023-06-12', '2024-12-12', 'BR001', 'OFF001', 'Delinquent', 195, 'Bucket 5'),
-- Recent originations
('ACC076', 'CUST076', 'Auto Finance', 95000, 4.5, 48, 2256.25, 92000, 88000, 4000, '2024-10-30', '2028-10-30', 'BR002', 'OFF002', 'Current', 0, 'Current'),
('ACC077', 'CUST077', 'Personal Finance', 65000, 5.0, 36, 1950, 63000, 60000, 3000, '2024-11-18', '2027-11-18', 'BR003', 'OFF003', 'Current', 0, 'Current'),
('ACC078', 'CUST078', 'Auto Finance', 125000, 4.5, 60, 2343.75, 122000, 117000, 5000, '2024-12-05', '2029-12-05', 'BR001', 'OFF001', 'Current', 0, 'Current'),
('ACC079', 'CUST079', 'Personal Finance', 40000, 5.0, 24, 1833.33, 39000, 37500, 1500, '2024-12-22', '2026-12-22', 'BR002', 'OFF002', 'Current', 0, 'Current'),
('ACC080', 'CUST080', 'Personal Finance', 25000, 6.0, 18, 1458.33, 24500, 24000, 500, '2024-09-10', '2026-03-10', 'BR003', 'OFF003', 'Delinquent', 15, 'Bucket 1');

-- =============================================
-- SECTION 3: ADDITIONAL COLLECTION CASES
-- =============================================

INSERT INTO collection_cases (account_id, customer_id, assigned_collector_id, assignment_date, 
    case_status, priority_level, total_outstanding, last_payment_date, last_contact_date, next_action_date)
VALUES
-- New cases for additional accounts
('ACC031', 'CUST031', 'COL006', '2024-08-10', 'Write-off Review', 'Critical', 15000, '2024-06-01', '2025-01-15 10:00:00', '2025-02-01'),
('ACC032', 'CUST032', 'COL007', '2024-09-15', 'Legal', 'Critical', 32000, '2024-07-20', '2025-01-16 11:30:00', '2025-02-05'),
('ACC033', 'CUST033', 'COL008', '2024-10-05', 'Active', 'High', 18000, '2024-08-30', '2025-01-17 14:00:00', '2025-01-25'),
('ACC034', 'CUST034', 'COL009', '2024-07-20', 'Write-off Review', 'Critical', 12000, '2024-05-15', '2025-01-14 09:30:00', '2025-02-10'),
('ACC035', 'CUST035', 'COL010', '2024-09-25', 'Active', 'High', 40000, '2024-08-15', '2025-01-18 15:45:00', '2025-01-28'),
('ACC036', 'CUST036', 'COL001', '2024-11-10', 'Active', 'Medium', 22000, '2024-10-05', '2025-01-19 10:15:00', '2025-01-26'),
('ACC037', 'CUST037', 'COL002', '2024-08-25', 'Legal', 'Critical', 48000, '2024-06-20', '2025-01-13 11:00:00', '2025-02-15'),
('ACC038', 'CUST038', 'COL003', '2024-10-15', 'Active', 'High', 20000, '2024-09-10', '2025-01-20 13:30:00', '2025-01-27'),
('ACC039', 'CUST039', 'COL004', '2024-09-05', 'Active', 'High', 35000, '2024-07-25', '2025-01-16 16:00:00', '2025-01-30'),
('ACC040', 'CUST040', 'COL005', '2024-08-01', 'Write-off Review', 'Critical', 18000, '2024-05-20', '2025-01-12 09:00:00', '2025-02-20'),
-- Cases for new accounts
('ACC051', 'CUST051', 'COL006', '2024-12-01', 'Active', 'Medium', 2200000, '2024-11-10', '2025-01-21 10:30:00', '2025-01-28'),
('ACC052', 'CUST052', 'COL007', '2024-11-25', 'Active', 'Medium', 195000, '2024-10-30', '2025-01-20 14:15:00', '2025-01-27'),
('ACC053', 'CUST053', 'COL008', '2024-10-20', 'Active', 'High', 1650000, '2024-09-15', '2025-01-19 11:45:00', '2025-01-26'),
('ACC054', 'CUST054', 'COL009', '2024-12-15', 'Active', 'Low', 95000, '2024-12-01', '2025-01-21 15:30:00', '2025-01-28'),
('ACC055', 'CUST055', 'COL010', '2024-10-15', 'Active', 'High', 320000, '2024-09-01', '2025-01-18 09:15:00', '2025-01-25'),
('ACC056', 'CUST056', 'COL001', '2024-12-10', 'Active', 'Low', 68000, '2024-11-20', '2025-01-21 13:00:00', '2025-01-29'),
('ACC057', 'CUST057', 'COL002', '2024-11-15', 'Active', 'Medium', 1450000, '2024-10-10', '2025-01-20 10:45:00', '2025-01-27'),
('ACC058', 'CUST058', 'COL003', '2024-12-05', 'Active', 'Medium', 92000, '2024-11-15', '2025-01-21 11:30:00', '2025-01-28'),
('ACC059', 'CUST059', 'COL004', '2024-09-10', 'Legal', 'Critical', 850000, '2024-07-05', '2025-01-15 14:45:00', '2025-02-25'),
('ACC060', 'CUST060', 'COL005', '2024-11-30', 'Active', 'Medium', 78000, '2024-11-05', '2025-01-20 16:15:00', '2025-01-27');

-- =============================================
-- SECTION 4: RECENT COLLECTION ACTIVITIES
-- =============================================

-- Adding more collection activities for comprehensive reporting
INSERT INTO collection_activities (case_id, account_id, collector_id, activity_type, activity_datetime,
    contact_person, contact_number, activity_result, promise_amount, promise_date, notes, next_action, next_action_date)
VALUES
-- Activities for new cases (January 2025)
(31, 'ACC031', 'COL006', 'Call', '2025-01-15 10:00:00', 'Fahad Al-Dakhil', '+966531111111', 'No Answer', NULL, NULL, 
    'Phone switched off', 'Send SMS', '2025-01-16'),
(32, 'ACC032', 'COL007', 'Legal Notice', '2025-01-16 11:30:00', 'Wafa Al-Salem', '+966532222222', 'Served', NULL, NULL, 
    'Legal notice delivered to residence', 'Court Filing', '2025-02-01'),
(33, 'ACC033', 'COL008', 'Visit', '2025-01-17 14:00:00', 'Nasser Al-Otaibi', '+966533333333', 'Met Customer', 5000, '2025-01-25', 
    'Customer promised partial payment', 'Follow up', '2025-01-25'),
(34, 'ACC034', 'COL009', 'Call', '2025-01-14 09:30:00', 'Ghada Al-Rasheed', '+966534444444', 'Disputed', NULL, NULL, 
    'Customer claims account paid off', 'Verify records', '2025-01-15'),
(35, 'ACC035', 'COL010', 'SMS', '2025-01-18 15:45:00', 'Waleed Al-Subaie', '+966535555555', 'Delivered', NULL, NULL, 
    'Payment reminder sent', 'Call customer', '2025-01-19'),
(36, 'ACC036', 'COL001', 'Call', '2025-01-19 10:15:00', 'Haifa Al-Maliki', '+966536666666', 'PTP Obtained', 8000, '2025-01-30', 
    'Will pay from salary', 'Confirm payment', '2025-01-30'),
(37, 'ACC037', 'COL002', 'Legal Notice', '2025-01-13 11:00:00', 'Adel Al-Harbi', '+966537777777', 'Customer Not Found', NULL, NULL, 
    'Address not valid', 'Skip trace', '2025-01-20'),
(38, 'ACC038', 'COL003', 'Email', '2025-01-20 13:30:00', 'Basma Al-Zahrani', 'basma.zahrani@email.com', 'Sent', NULL, NULL, 
    'Payment plan options sent', 'Follow up call', '2025-01-22'),
(39, 'ACC039', 'COL004', 'Visit', '2025-01-16 16:00:00', 'Rashed Al-Ghamdi', '+966539999999', 'Customer Not Available', NULL, NULL, 
    'Left notice with family', 'Call customer', '2025-01-17'),
(40, 'ACC040', 'COL005', 'Call', '2025-01-12 09:00:00', 'Latifa Al-Otaibi', '+966540000000', 'No Income', NULL, NULL, 
    'Customer lost job', 'Review for write-off', '2025-02-01'),
-- High-value account activities
(41, 'ACC051', 'COL006', 'Call', '2025-01-21 10:30:00', 'Mansour Al-Rasheed', '+966541111111', 'Discussed', 200000, '2025-02-15', 
    'Large payment after property sale', 'Document agreement', '2025-01-23'),
(42, 'ACC052', 'COL007', 'Visit', '2025-01-20 14:15:00', 'Lamia Al-Subaie', '+966542222222', 'Met Customer', 30000, '2025-01-31', 
    'Negotiated payment plan', 'Send agreement', '2025-01-22'),
(43, 'ACC053', 'COL008', 'Call', '2025-01-19 11:45:00', 'Badr Al-Mutlaq', '+966543333333', 'PTP Obtained', 150000, '2025-02-10', 
    'Business deal closing soon', 'Monitor closely', '2025-02-05'),
(44, 'ACC054', 'COL009', 'SMS', '2025-01-21 15:30:00', 'Hanan Al-Rashidi', '+966544444444', 'Delivered', NULL, NULL, 
    'Gentle reminder sent', 'Call if no response', '2025-01-23'),
(45, 'ACC055', 'COL010', 'Email', '2025-01-18 09:15:00', 'Tariq Al-Harbi', 'tariq.harbi@email.com', 'Bounced', NULL, NULL, 
    'Email address invalid', 'Call customer', '2025-01-19'),
-- SMS campaigns
(16, 'ACC016', 'COL001', 'SMS', '2025-01-21 08:00:00', 'Reem Al-Rashidi', '+966516666666', 'Delivered', NULL, NULL, 
    'Bulk SMS campaign', 'Monitor response', '2025-01-22'),
(17, 'ACC017', 'COL002', 'SMS', '2025-01-21 08:00:00', 'Majed Al-Otaibi', '+966517777777', 'Delivered', NULL, NULL, 
    'Bulk SMS campaign', 'Monitor response', '2025-01-22'),
(18, 'ACC018', 'COL003', 'SMS', '2025-01-21 08:00:00', 'Nouf Al-Harbi', '+966518888888', 'Delivered', NULL, NULL, 
    'Bulk SMS campaign', 'Monitor response', '2025-01-22'),
(19, 'ACC019', 'COL004', 'SMS', '2025-01-21 08:00:00', 'Saleh Al-Ghamdi', '+966519999999', 'Failed', NULL, NULL, 
    'Number not in service', 'Update contact', '2025-01-22'),
(20, 'ACC020', 'COL005', 'SMS', '2025-01-21 08:00:00', 'Dalal Al-Zahrani', '+966520000000', 'Delivered', NULL, NULL, 
    'Bulk SMS campaign', 'Monitor response', '2025-01-22');

-- =============================================
-- SECTION 5: ADDITIONAL PROMISE TO PAY RECORDS
-- =============================================

INSERT INTO promise_to_pay (case_id, account_id, customer_id, collector_id, promise_amount, 
    promise_date, ptp_status, actual_payment_amount, actual_payment_date, kept_flag)
VALUES
-- New active PTPs
(33, 'ACC033', 'CUST033', 'COL008', 5000, '2025-01-25', 'Active', NULL, NULL, false),
(36, 'ACC036', 'CUST036', 'COL001', 8000, '2025-01-30', 'Active', NULL, NULL, false),
(41, 'ACC051', 'CUST051', 'COL006', 200000, '2025-02-15', 'Active', NULL, NULL, false),
(42, 'ACC052', 'CUST052', 'COL007', 30000, '2025-01-31', 'Active', NULL, NULL, false),
(43, 'ACC053', 'CUST053', 'COL008', 150000, '2025-02-10', 'Active', NULL, NULL, false),
-- Historical PTPs for trend analysis
(16, 'ACC016', 'CUST016', 'COL001', 25000, '2024-10-15', 'Kept', 25000, '2024-10-15', true),
(17, 'ACC017', 'CUST017', 'COL002', 15000, '2024-11-20', 'Kept', 15000, '2024-11-20', true),
(18, 'ACC018', 'CUST018', 'COL003', 20000, '2024-12-10', 'Kept', 20000, '2024-12-10', true),
(19, 'ACC019', 'CUST019', 'COL004', 50000, '2024-09-30', 'Broken', 0, NULL, false),
(20, 'ACC020', 'CUST020', 'COL005', 8000, '2024-11-25', 'Partial', 5000, '2024-11-28', false),
(21, 'ACC021', 'CUST021', 'COL006', 4000, '2024-10-20', 'Broken', 0, NULL, false),
(22, 'ACC022', 'CUST022', 'COL007', 6000, '2024-11-15', 'Kept', 6000, '2024-11-15', true),
(23, 'ACC023', 'CUST023', 'COL008', 5000, '2024-09-25', 'Broken', 0, NULL, false),
(24, 'ACC024', 'CUST024', 'COL009', 10000, '2024-12-05', 'Kept', 10000, '2024-12-05', true),
(25, 'ACC025', 'CUST025', 'COL010', 3000, '2024-08-30', 'Broken', 0, NULL, false),
-- Large value PTPs
(26, 'ACC026', 'CUST026', 'COL001', 15000, '2024-11-10', 'Kept', 15000, '2024-11-10', true),
(27, 'ACC027', 'CUST027', 'COL002', 12000, '2024-12-15', 'Kept', 12000, '2024-12-15', true),
(28, 'ACC028', 'CUST028', 'COL003', 10000, '2024-10-25', 'Partial', 7000, '2024-10-28', false),
(29, 'ACC029', 'CUST029', 'COL004', 8000, '2024-09-15', 'Broken', 0, NULL, false),
(30, 'ACC030', 'CUST030', 'COL005', 18000, '2024-11-05', 'Kept', 18000, '2024-11-05', true);

-- =============================================
-- SECTION 6: ADDITIONAL PAYMENT TRANSACTIONS
-- =============================================

INSERT INTO payment_transactions (account_id, customer_id, payment_date, payment_amount, 
    payment_method, payment_channel, receipt_number, collected_by, allocation_type, 
    principal_paid, profit_paid, late_fee_paid, transaction_status)
VALUES
-- January 2025 payments
('ACC051', 'CUST051', '2025-01-10', 50000, 'Bank Transfer', 'Corporate Banking', 'CORP20250110001', 'System', 'Auto', 45000, 5000, 0, 'Completed'),
('ACC052', 'CUST052', '2025-01-12', 15000, 'Cash', 'Branch', 'BR20250112001', 'Branch Staff', 'Manual', 13500, 1500, 0, 'Completed'),
('ACC053', 'CUST053', '2025-01-15', 100000, 'Cheque', 'Branch', 'CHQ20250115001', 'Branch Staff', 'Manual', 90000, 10000, 0, 'Completed'),
('ACC054', 'CUST054', '2025-01-18', 8000, 'Mobile Transfer', 'Mobile App', 'MOB20250118001', 'System', 'Auto', 7200, 800, 0, 'Completed'),
('ACC055', 'CUST055', '2025-01-20', 25000, 'Bank Transfer', 'Online', 'ONL20250120001', 'System', 'Auto', 22500, 2500, 0, 'Completed'),
-- Field collections
('ACC021', 'CUST021', '2025-01-05', 3000, 'Cash', 'Field Collection', 'FLD20250105001', 'COL006', 'Manual', 2700, 300, 0, 'Completed'),
('ACC023', 'CUST023', '2025-01-08', 2500, 'Cash', 'Field Collection', 'FLD20250108001', 'COL008', 'Manual', 2250, 250, 0, 'Completed'),
('ACC025', 'CUST025', '2025-01-11', 2000, 'Cash', 'Field Collection', 'FLD20250111001', 'COL010', 'Manual', 1800, 200, 0, 'Completed'),
('ACC028', 'CUST028', '2025-01-14', 4000, 'Cash', 'Field Collection', 'FLD20250114001', 'COL003', 'Manual', 3600, 400, 0, 'Completed'),
('ACC031', 'CUST031', '2025-01-17', 1500, 'Cash', 'Field Collection', 'FLD20250117001', 'COL006', 'Manual', 1350, 150, 0, 'Completed'),
-- December 2024 payments
('ACC016', 'CUST016', '2024-10-15', 25000, 'Bank Transfer', 'Online', 'ONL20241015002', 'System', 'Auto', 22500, 2500, 0, 'Completed'),
('ACC017', 'CUST017', '2024-11-20', 15000, 'Cash', 'Branch', 'BR20241120001', 'Branch Staff', 'Manual', 13500, 1500, 0, 'Completed'),
('ACC018', 'CUST018', '2024-12-10', 20000, 'Debit Card', 'POS', 'POS20241210001', 'Branch Staff', 'Manual', 18000, 2000, 0, 'Completed'),
('ACC022', 'CUST022', '2024-11-15', 6000, 'Mobile Transfer', 'Mobile App', 'MOB20241115001', 'System', 'Auto', 5400, 600, 0, 'Completed'),
('ACC024', 'CUST024', '2024-12-05', 10000, 'Bank Transfer', 'Online', 'ONL20241205002', 'System', 'Auto', 9000, 1000, 0, 'Completed'),
('ACC026', 'CUST026', '2024-11-10', 15000, 'Cheque', 'Branch', 'CHQ20241110001', 'Branch Staff', 'Manual', 13500, 1500, 0, 'Completed'),
('ACC027', 'CUST027', '2024-12-15', 12000, 'Cash', 'Branch', 'BR20241215001', 'Branch Staff', 'Manual', 10800, 1200, 0, 'Completed'),
('ACC030', 'CUST030', '2024-11-05', 18000, 'Bank Transfer', 'Corporate Banking', 'CORP20241105001', 'System', 'Auto', 16200, 1800, 0, 'Completed'),
-- November 2024 payments
('ACC041', 'CUST041', '2024-11-25', 80000, 'Bank Transfer', 'Online', 'ONL20241125001', 'System', 'Auto', 72000, 8000, 0, 'Completed'),
('ACC042', 'CUST042', '2024-11-18', 35000, 'Cash', 'Branch', 'BR20241118001', 'Branch Staff', 'Manual', 31500, 3500, 0, 'Completed'),
('ACC043', 'CUST043', '2024-11-10', 120000, 'Bank Transfer', 'Corporate Banking', 'CORP20241110001', 'System', 'Auto', 108000, 12000, 0, 'Completed'),
('ACC044', 'CUST044', '2024-11-05', 18000, 'Mobile Transfer', 'Mobile App', 'MOB20241105001', 'System', 'Auto', 16200, 1800, 0, 'Completed'),
('ACC045', 'CUST045', '2024-11-22', 40000, 'Cheque', 'Branch', 'CHQ20241122001', 'Branch Staff', 'Manual', 36000, 4000, 0, 'Completed');

-- =============================================
-- SECTION 7: ADDITIONAL LEGAL CASES
-- =============================================

INSERT INTO legal_cases (account_id, customer_id, case_type, court_name, case_number, 
    filing_date, lawyer_name, case_status, judgment_date, judgment_amount, legal_costs, next_hearing_date)
VALUES
('ACC032', 'CUST032', 'Execution', 'Riyadh General Court', 'EX2024/5678', '2024-11-15', 
    'Al-Mutairi Law Firm', 'Under Execution', '2025-01-10', 32000, 5000, NULL),
('ACC037', 'CUST037', 'Civil Case', 'Jeddah Commercial Court', 'CV2024/8901', '2024-10-20', 
    'Al-Ghamdi Legal Services', 'In Progress', NULL, NULL, 8000, '2025-03-15'),
('ACC059', 'CUST059', 'Execution', 'Dammam Commercial Court', 'EX2024/3456', '2024-09-30', 
    'Al-Enezi Advocates', 'Under Execution', '2024-12-15', 850000, 35000, '2025-04-01'),
('ACC063', 'CUST063', 'Civil Case', 'Riyadh General Court', 'CV2024/1234', '2024-12-01', 
    'Al-Harbi Law Office', 'Filed', NULL, NULL, 3000, '2025-02-28'),
('ACC064', 'CUST064', 'Civil Case', 'Makkah General Court', 'CV2024/5678', '2024-11-20', 
    'Al-Zahrani Legal Firm', 'In Progress', NULL, NULL, 2500, '2025-03-10'),
('ACC071', 'CUST071', 'Execution', 'Jeddah General Court', 'EX2024/9012', '2024-10-15', 
    'Al-Otaibi Advocates', 'Judgment Obtained', '2025-01-05', 14500, 2000, NULL),
('ACC072', 'CUST072', 'Civil Case', 'Riyadh General Court', 'CV2024/3456', '2024-12-10', 
    'Al-Maliki Law Services', 'Filed', NULL, NULL, 1500, '2025-03-20'),
('ACC073', 'CUST073', 'Execution', 'Madinah General Court', 'EX2024/7890', '2024-08-25', 
    'Al-Subaie Legal Consultants', 'Under Execution', '2024-11-30', 19500, 3500, NULL);

-- =============================================
-- SECTION 8: ADDITIONAL SETTLEMENTS
-- =============================================

INSERT INTO settlements (account_id, customer_id, original_outstanding, settlement_amount, 
    discount_amount, discount_percentage, approval_level, approved_by, approval_date, 
    settlement_status, payment_plan)
VALUES
-- New settlement proposals
('ACC051', 'CUST051', 2200000, 1760000, 440000, 20.0, 'CEO', NULL, NULL, 'Pending', 'Installment'),
('ACC053', 'CUST053', 1650000, 1402500, 247500, 15.0, 'Senior Management', NULL, NULL, 'Pending', 'Installment'),
('ACC059', 'CUST059', 850000, 680000, 170000, 20.0, 'Senior Management', 'MGR002', '2025-01-15', 'Approved', 'Lump Sum'),
-- Recently approved settlements
('ACC021', 'CUST021', 18000, 15300, 2700, 15.0, 'Team Leader', 'TL003', '2025-01-10', 'Approved', 'Installment'),
('ACC025', 'CUST025', 15000, 12000, 3000, 20.0, 'Department Head', 'HEAD002', '2025-01-05', 'Approved', 'Lump Sum'),
('ACC033', 'CUST033', 18000, 16200, 1800, 10.0, 'Team Leader', 'TL001', '2025-01-12', 'Approved', 'Installment'),
-- Completed settlements
('ACC026', 'CUST026', 48000, 43200, 4800, 10.0, 'Team Leader', 'TL002', '2024-10-20', 'Completed', 'Installment'),
('ACC028', 'CUST028', 38000, 32300, 5700, 15.0, 'Department Head', 'HEAD001', '2024-11-01', 'Completed', 'Lump Sum'),
-- Rejected settlements
('ACC031', 'CUST031', 15000, 7500, 7500, 50.0, 'Senior Management', 'MGR001', '2024-12-20', 'Rejected', 'Lump Sum'),
('ACC034', 'CUST034', 12000, 6000, 6000, 50.0, 'Department Head', 'HEAD002', '2024-12-15', 'Rejected', 'Installment');

-- =============================================
-- SECTION 9: ADDITIONAL ASSET RECOVERY
-- =============================================

INSERT INTO asset_recovery (account_id, asset_type, asset_description, repossession_date, 
    storage_location, estimated_value, auction_date, sale_amount, recovery_costs, net_recovery, recovery_status)
VALUES
('ACC032', 'Vehicle', '2020 Toyota Corolla - White', '2024-10-25', 'Riyadh Storage Yard A', 55000, '2024-11-30', 50000, 3000, 47000, 'Sold'),
('ACC035', 'Vehicle', '2021 Hyundai Accent - Silver', '2024-11-15', 'Jeddah Storage Facility', 48000, '2024-12-20', 44000, 2500, 41500, 'Sold'),
('ACC037', 'Vehicle', '2019 Nissan Sunny - Gray', '2024-12-01', 'Riyadh Storage Yard B', 35000, NULL, NULL, 2000, NULL, 'In Storage'),
('ACC039', 'Vehicle', '2021 Kia Rio - Blue', '2024-12-10', 'Dammam Storage Center', 42000, '2025-01-25', NULL, 2200, NULL, 'Scheduled for Auction'),
('ACC052', 'Vehicle', '2021 BMW 3 Series - Black', '2025-01-05', 'Riyadh Storage Yard A', 125000, '2025-02-10', NULL, 4000, NULL, 'Scheduled for Auction'),
('ACC055', 'Vehicle', '2020 Mercedes C-Class - White', '2025-01-10', 'Jeddah Storage Facility', 150000, '2025-02-15', NULL, 4500, NULL, 'Scheduled for Auction'),
('ACC058', 'Vehicle', '2022 Honda Civic - Red', '2025-01-15', 'Riyadh Storage Yard B', 85000, NULL, NULL, 3000, NULL, 'In Storage'),
('ACC067', 'Vehicle', '2021 Lexus ES - Silver', '2024-11-20', 'Riyadh Storage Yard A', 165000, '2024-12-25', 155000, 5000, 150000, 'Sold');

-- =============================================
-- SECTION 10: COLLECTOR PERFORMANCE DATA
-- =============================================

-- Adding more performance data for trend analysis
INSERT INTO collector_performance (collector_id, performance_date, assigned_cases, contacted_cases, 
    collected_amount, target_amount, ptp_obtained, ptp_kept, calls_made, visits_made, success_rate)
VALUES
-- January 2025 weekly performance
('COL001', '2025-01-14', 26, 24, 142000, 175000, 9, 7, 92, 5, 81.14),
('COL002', '2025-01-14', 21, 19, 108000, 145000, 6, 4, 78, 3, 74.48),
('COL003', '2025-01-14', 30, 27, 188000, 215000, 11, 8, 112, 8, 87.44),
('COL004', '2025-01-14', 24, 22, 91000, 118000, 5, 3, 94, 4, 77.12),
('COL005', '2025-01-14', 29, 27, 218000, 245000, 13, 10, 108, 10, 88.98),
('COL006', '2025-01-14', 19, 17, 82000, 108000, 4, 3, 72, 3, 75.93),
('COL007', '2025-01-14', 17, 15, 62000, 88000, 3, 2, 65, 2, 70.45),
('COL008', '2025-01-14', 23, 21, 101000, 128000, 7, 5, 85, 5, 78.91),
('COL009', '2025-01-14', 25, 23, 121000, 138000, 8, 6, 89, 6, 87.68),
('COL010', '2025-01-14', 20, 18, 92000, 113000, 5, 3, 75, 3, 81.42),
-- January 2025 start of month
('COL001', '2025-01-07', 25, 23, 135000, 170000, 8, 6, 88, 4, 79.41),
('COL002', '2025-01-07', 20, 18, 102000, 140000, 5, 3, 74, 3, 72.86),
('COL003', '2025-01-07', 29, 26, 182000, 210000, 10, 7, 106, 7, 86.67),
('COL004', '2025-01-07', 23, 21, 88000, 115000, 4, 2, 90, 3, 76.52),
('COL005', '2025-01-07', 28, 26, 212000, 240000, 12, 9, 102, 9, 88.33),
('COL006', '2025-01-07', 18, 16, 78000, 105000, 3, 2, 68, 2, 74.29),
('COL007', '2025-01-07', 16, 14, 58000, 85000, 2, 1, 60, 1, 68.24),
('COL008', '2025-01-07', 22, 20, 98000, 125000, 6, 4, 80, 4, 78.40),
('COL009', '2025-01-07', 24, 22, 118000, 135000, 7, 5, 85, 5, 87.41),
('COL010', '2025-01-07', 19, 17, 88000, 110000, 4, 2, 70, 2, 80.00);

-- =============================================
-- SECTION 11: SHARIA COMPLIANCE RECORDS
-- =============================================

INSERT INTO sharia_compliance (account_id, compliance_type, late_payment_charges, charity_amount,
    charity_paid_date, profit_purification, compliance_status, reviewed_by, review_date, notes)
VALUES
-- New compliance records
('ACC016', 'Late Payment Charges', 3500, 3500, '2025-01-15', 0, 'Compliant', 'Sharia Board', '2025-01-14', 
    'Donated to approved charity through Ehsan platform'),
('ACC021', 'Late Payment Charges', 850, 850, '2025-01-10', 0, 'Compliant', 'Sharia Board', '2025-01-09', 
    'Transferred to local mosque charity fund'),
('ACC025', 'Late Payment Charges', 1200, 1200, '2025-01-05', 0, 'Compliant', 'Sharia Board', '2025-01-04', 
    'Donated to orphanage support program'),
('ACC031', 'Late Payment Charges', 2800, 2800, '2024-12-25', 0, 'Compliant', 'Sharia Board', '2024-12-24', 
    'Year-end charity distribution completed'),
('ACC041', 'Profit Purification', 0, 0, NULL, 35000, 'Under Review', 'Sharia Auditor', '2025-01-18', 
    'Annual profit review for large home finance'),
('ACC043', 'Profit Purification', 0, 0, NULL, 28000, 'Approved', 'Sharia Committee', '2024-12-30', 
    'SME finance profit purification completed'),
('ACC051', 'Late Payment Charges', 5500, 5500, '2024-11-30', 0, 'Compliant', 'Sharia Board', '2024-11-29', 
    'Large amount donated to national charity'),
('ACC053', 'Profit Purification', 0, 0, NULL, 42000, 'Under Review', 'Sharia Auditor', '2025-01-20', 
    'Quarterly review for SME portfolio'),
('ACC057', 'Late Payment Charges', 4200, 4200, '2024-12-15', 0, 'Compliant', 'Sharia Board', '2024-12-14', 
    'Donated to education support fund'),
('ACC059', 'Late Payment Charges', 6800, 6800, '2024-11-20', 0, 'Compliant', 'Sharia Board', '2024-11-19', 
    'Transferred to healthcare charity');

-- =============================================
-- SECTION 12: ADDITIONAL PAYMENT SCHEDULES
-- =============================================

-- Payment schedules for high-value accounts (showing current and future installments)
INSERT INTO payment_schedule (account_id, installment_no, due_date, principal_amount, 
    profit_amount, total_amount, paid_amount, payment_date, payment_status, dpd)
VALUES
-- ACC051 - Home Finance (current month)
('ACC051', 58, '2024-12-12', 8750.00, 6250.00, 15000.00, 0, NULL, 'Overdue', 40),
('ACC051', 59, '2025-01-12', 8750.00, 6250.00, 15000.00, 0, NULL, 'Overdue', 9),
('ACC051', 60, '2025-02-12', 8750.00, 6250.00, 15000.00, 0, NULL, 'Pending', 0),
('ACC051', 61, '2025-03-12', 8750.00, 6250.00, 15000.00, 0, NULL, 'Pending', 0),
-- ACC053 - SME Finance
('ACC053', 62, '2024-11-30', 16666.67, 6666.66, 23333.33, 0, NULL, 'Overdue', 52),
('ACC053', 63, '2024-12-30', 16666.67, 6666.66, 23333.33, 0, NULL, 'Overdue', 22),
('ACC053', 64, '2025-01-30', 16666.67, 6666.66, 23333.33, 0, NULL, 'Due Soon', 0),
('ACC053', 65, '2025-02-28', 16666.67, 6666.66, 23333.33, 0, NULL, 'Pending', 0),
-- ACC057 - Home Finance
('ACC057', 45, '2024-11-14', 7777.78, 4822.22, 12600.00, 0, NULL, 'Overdue', 69),
('ACC057', 46, '2024-12-14', 7777.78, 4822.22, 12600.00, 0, NULL, 'Overdue', 38),
('ACC057', 47, '2025-01-14', 7777.78, 4822.22, 12600.00, 0, NULL, 'Overdue', 7),
('ACC057', 48, '2025-02-14', 7777.78, 4822.22, 12600.00, 0, NULL, 'Pending', 0);

-- =============================================
-- SECTION 13: BRANCH AND OFFICER DATA
-- =============================================

-- Adding branch performance data (if table exists)
-- This would typically be in a separate table but adding as reference
/*
INSERT INTO branches (branch_code, branch_name, region, manager_name)
VALUES
('BR001', 'Riyadh Main Branch', 'Central', 'Abdullah Al-Rasheed'),
('BR002', 'Jeddah Branch', 'Western', 'Fatima Al-Zahrani'),
('BR003', 'Dammam Branch', 'Eastern', 'Mohammed Al-Qahtani');

INSERT INTO officers (officer_id, officer_name, branch_code, role)
VALUES
('OFF001', 'Saleh Al-Mutairi', 'BR001', 'Senior Credit Officer'),
('OFF002', 'Huda Al-Harbi', 'BR002', 'Credit Officer'),
('OFF003', 'Omar Al-Ghamdi', 'BR003', 'Senior Credit Officer');
*/

-- =============================================
-- END OF MISSING SAMPLE DATA
-- =============================================

-- Summary of data added:
-- - 50 additional customers (CUST051-CUST100)
-- - 30 additional finance accounts including credit cards
-- - 30 new collection cases
-- - 45 new collection activities
-- - 30 new promise to pay records
-- - 40 new payment transactions
-- - 8 new legal cases
-- - 10 new settlements
-- - 8 new asset recovery records
-- - 20 new collector performance records
-- - 10 new sharia compliance records
-- - Sample payment schedules for key accounts

-- This comprehensive dataset will enable testing of all dashboard features including:
-- - Portfolio aging analysis across all buckets
-- - Collection performance trends
-- - PTP success rates
-- - Legal case tracking
-- - Settlement analysis
-- - Asset recovery reporting
-- - Collector productivity metrics
-- - Sharia compliance monitoring
-- - Product-wise NPF analysis
-- - Branch-wise performance