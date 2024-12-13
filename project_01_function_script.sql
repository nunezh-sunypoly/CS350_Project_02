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

