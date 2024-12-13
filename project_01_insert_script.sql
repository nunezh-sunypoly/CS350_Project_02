-- Insert into occupations
INSERT INTO occupations (occupation_id, occupation_code, occupation_title, description) VALUES
(1, '11-1021', 'General and Operations Managers', 'Plan, direct, or coordinate the operations of public or private sector organizations.');
(6, '13-2011', 'Accountants and Auditors', 'Examine financial records and prepare financial reports.'),
(7, '15-1132', 'Software Developers', 'Develop, create, and modify general computer applications software or specialized utility programs.'),
(8, '29-1141', 'Registered Nurses', 'Provide and coordinate patient care, educate patients about health conditions.'),
(9, '47-2061', 'Construction Laborers', 'Perform tasks involving physical labor at construction sites.')
ON CONFLICT (occupation_id) DO NOTHING;


-- Insert into state_data
INSERT INTO state_data (state_id, state_code, state_name) VALUES
(1, 'CA', 'California'),
(2, 'TX', 'Texas');
(6, 'NY', 'New York'),
(7, 'FL', 'Florida'),
(8, 'WA', 'Washington'),
(9, 'IL', 'Illinois')
ON CONFLICT (state_id) DO NOTHING;

-- Insert into employment_data
INSERT INTO employment_data (employment_id, occupation_id, date, state_id, employment, employment_rse) VALUES
(1, 1, to_date('19-09-2022', 'DD-MM-YYYY'), 1, 50000, 1.5), -- California
(2, 1, to_date('11-06-2020', 'DD-MM-YYYY'), 2, 30000, 1.7); -- Texas
(6, 8, to_date('01-01-2020', 'DD-MM-YYYY'), 6, 100000, 1.1), -- New York, Registered Nurses
(7, 9, to_date('12-07-2019', 'DD-MM-YYYY'), 7, 75000, 1.6), -- Florida, Construction Laborers
(8, 6, to_date('05-02-2018', 'DD-MM-YYYY'), 8, 45000, 1.8), -- Washington, Accountants and Auditors
(9, 7, to_date('17-08-2023', 'DD-MM-YYYY'), 9, 85000, 1.5) -- Illinois, Software Developers
ON CONFLICT (employment_id) DO NOTHING;

-- Insert into wages
INSERT INTO wages (wage_id, occupation_id, date, state_id, hourly_mean_wage, annual_mean_wage, wage_rse) VALUES
(1, 1, to_date('19-09-2022', 'DD-MM-YYYY'), 1, 50.75, 105560, 1.2), -- California
(2, 1, to_date('11-06-2020', 'DD-MM-YYYY'), 2, 48.20, 100256, 1.4); -- Texas
(6, 8, to_date('20-10-2020', 'DD-MM-YYYY'), 6, 37.45, 77896, 1.2), -- New York, Registered Nurses
(7, 9, to_date('28-05-2019', 'DD-MM-YYYY'), 7, 20.00, 41600, 1.7), -- Florida, Construction Laborers
(8, 6, to_date('05-11-2015', 'DD-MM-YYYY'), 8, 38.00, 79140, 1.6), -- Washington, Accountants and Auditors
(9, 7, to_date('11-01-2022', 'DD-MM-YYYY'), 9, 60.00, 124800, 1.2) -- Illinois, Software Developers
ON CONFLICT (wage_id) DO NOTHING;
