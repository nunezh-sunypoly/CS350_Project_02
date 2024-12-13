CREATE OR REPLACE FUNCTION calculate_annual_wage(hourly_wage DECIMAL)
RETURNS DECIMAL AS $$
BEGIN
    RETURN hourly_wage * 2080; -- Assuming 40 hours/week and 52 weeks/year
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_employment_and_wages(
    p_occupation_id INT, p_date DATE, p_state_id INT, p_employment INT,
    p_hourly_wage DECIMAL, p_wage_rse DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update employment data
    UPDATE employment_data
    SET employment = p_employment
    WHERE occupation_id = p_occupation_id AND year = p_date AND state_id = p_state_id;

    -- Update wages
    UPDATE wages
    SET hourly_mean_wage = p_hourly_wage, wage_rse = p_wage_rse
    WHERE occupation_id = p_occupation_id AND date = p_date AND state_id = p_state_id;
END;
$$;

CREATE OR REPLACE PROCEDURE update_employment_data(
    occupation INT,
    yr DATE,
    state INT,
    new_employment INT,
    new_employment_rse NUMERIC
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE employment_data
    SET employment = new_employment,
        employment_rse = new_employment_rse
    WHERE occupation_id = occupation
      AND date = yr  -- Use the parameter yr here
      AND state_id = state;
END;
$$;


CREATE OR REPLACE PROCEDURE add_occupation(
    code VARCHAR,
    title VARCHAR,
    description_text TEXT
)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO occupations (occupation_code, occupation_title, description)
    VALUES (code, title, description_text);
END;
$$;

CREATE OR REPLACE FUNCTION get_avg_wage(occupation INT)
RETURNS NUMERIC AS $$
BEGIN
    RETURN (SELECT AVG(annual_mean_wage)
            FROM wages
            WHERE occupation_id = occupation);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_avg_employment_rse(state_id INT)
RETURNS NUMERIC AS $$
BEGIN
    RETURN (SELECT AVG(employment_rse)
            FROM employment_data
            WHERE employment_data.state_id = get_avg_employment_rse.state_id);
END;
$$ LANGUAGE plpgsql;

