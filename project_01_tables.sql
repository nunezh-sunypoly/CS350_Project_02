-- Table for occupations
CREATE TABLE occupations (
    occupation_id SERIAL PRIMARY KEY,
    occupation_code VARCHAR(10) NOT NULL,
    occupation_title VARCHAR(255) NOT NULL,
    description TEXT
);

-- Table for state data
CREATE TABLE state_data (
    state_id SERIAL PRIMARY KEY,
    state_code VARCHAR(5) NOT NULL,
    state_name VARCHAR(50) NOT NULL
);

-- Table for employment data
CREATE TABLE employment_data (
    employment_id SERIAL PRIMARY KEY,
    occupation_id INT REFERENCES occupations(occupation_id),
    date DATE NOT NULL,
    state_id INT REFERENCES state_data(state_id),
    employment INT NOT NULL,
    employment_rse DECIMAL(5, 2)
);

-- Table for wages data
CREATE TABLE wages (
    wage_id SERIAL PRIMARY KEY,
    occupation_id INT REFERENCES occupations(occupation_id),
    date DATE NOT NULL,
    state_id INT REFERENCES state_data(state_id),
    hourly_mean_wage DECIMAL(10, 2),
    annual_mean_wage DECIMAL(10, 2),
    wage_rse DECIMAL(5, 2)
);
