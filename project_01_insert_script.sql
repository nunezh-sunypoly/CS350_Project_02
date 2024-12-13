-- Insert into occupations
INSERT INTO occupations (occupation_id, occupation_code, occupation_title, description) VALUES
(1, '11-1021', 'General and Operations Managers', 'Plan, direct, or coordinate the operations of public or private sector organizations.');

-- Insert into state_data
INSERT INTO state_data (state_id, state_code, state_name) VALUES
(1, 'CA', 'California'),
(2, 'TX', 'Texas');

-- Insert into employment_data
INSERT INTO employment_data (employment_id, occupation_id, date, state_id, employment, employment_rse) VALUES
(1, 1, to_date('19-09-2022', 'DD-MM-YYYY'), 1, 50000, 1.5), -- California
(2, 1, to_date('11-06-2020', 'DD-MM-YYYY'), 2, 30000, 1.7); -- Texas

-- Insert into wages
INSERT INTO wages (wage_id, occupation_id, date, state_id, hourly_mean_wage, annual_mean_wage, wage_rse) VALUES
(1, 1, to_date('19-09-2022', 'DD-MM-YYYY'), 1, 50.75, 105560, 1.2), -- California
(2, 1, to_date('11-06-2020', 'DD-MM-YYYY'), 2, 48.20, 100256, 1.4); -- Texas
