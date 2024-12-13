--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: add_prim_key(integer); Type: FUNCTION; Schema: public; Owner: nunezh
--

CREATE FUNCTION public.add_prim_key(wage_id integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
	begin
		SELECT annual_mean_wage
		FROM wages
		WHERE wage_id = 1;
	
	end;
$$;


ALTER FUNCTION public.add_prim_key(wage_id integer) OWNER TO nunezh;

--
-- Name: calculate_annual_wage(numeric); Type: FUNCTION; Schema: public; Owner: nunezh
--

CREATE FUNCTION public.calculate_annual_wage(hourly_wage numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN hourly_wage * 2080; -- Assuming 40 hours/week and 52 weeks/year
END;
$$;


ALTER FUNCTION public.calculate_annual_wage(hourly_wage numeric) OWNER TO nunezh;

--
-- Name: get_annual_mean_wage(integer); Type: FUNCTION; Schema: public; Owner: nunezh
--

CREATE FUNCTION public.get_annual_mean_wage(wage_id_as_input integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
	begin
		
		RETURN(SELECT annual_mean_wage
		FROM wages
		WHERE wage_id = wage_id_as_input);
	end
$$;


ALTER FUNCTION public.get_annual_mean_wage(wage_id_as_input integer) OWNER TO nunezh;

--
-- Name: update_employment_and_wages(integer, date, integer, integer, numeric, numeric); Type: PROCEDURE; Schema: public; Owner: nunezh
--

CREATE PROCEDURE public.update_employment_and_wages(IN p_occupation_id integer, IN p_date date, IN p_state_id integer, IN p_employment integer, IN p_hourly_wage numeric, IN p_wage_rse numeric)
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


ALTER PROCEDURE public.update_employment_and_wages(IN p_occupation_id integer, IN p_date date, IN p_state_id integer, IN p_employment integer, IN p_hourly_wage numeric, IN p_wage_rse numeric) OWNER TO nunezh;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: employment_data; Type: TABLE; Schema: public; Owner: nunezh
--

CREATE TABLE public.employment_data (
    employment_id integer NOT NULL,
    occupation_id integer,
    date date NOT NULL,
    state_id integer,
    employment integer NOT NULL,
    employment_rse numeric(5,2)
);


ALTER TABLE public.employment_data OWNER TO nunezh;

--
-- Name: employment_data_employment_id_seq; Type: SEQUENCE; Schema: public; Owner: nunezh
--

CREATE SEQUENCE public.employment_data_employment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employment_data_employment_id_seq OWNER TO nunezh;

--
-- Name: employment_data_employment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nunezh
--

ALTER SEQUENCE public.employment_data_employment_id_seq OWNED BY public.employment_data.employment_id;


--
-- Name: occupations; Type: TABLE; Schema: public; Owner: nunezh
--

CREATE TABLE public.occupations (
    occupation_id integer NOT NULL,
    occupation_code character varying(10) NOT NULL,
    occupation_title character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.occupations OWNER TO nunezh;

--
-- Name: occupations_occupation_id_seq; Type: SEQUENCE; Schema: public; Owner: nunezh
--

CREATE SEQUENCE public.occupations_occupation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.occupations_occupation_id_seq OWNER TO nunezh;

--
-- Name: occupations_occupation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nunezh
--

ALTER SEQUENCE public.occupations_occupation_id_seq OWNED BY public.occupations.occupation_id;


--
-- Name: state_data; Type: TABLE; Schema: public; Owner: nunezh
--

CREATE TABLE public.state_data (
    state_id integer NOT NULL,
    state_code character varying(5) NOT NULL,
    state_name character varying(50) NOT NULL
);


ALTER TABLE public.state_data OWNER TO nunezh;

--
-- Name: state_data_state_id_seq; Type: SEQUENCE; Schema: public; Owner: nunezh
--

CREATE SEQUENCE public.state_data_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_data_state_id_seq OWNER TO nunezh;

--
-- Name: state_data_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nunezh
--

ALTER SEQUENCE public.state_data_state_id_seq OWNED BY public.state_data.state_id;


--
-- Name: wages; Type: TABLE; Schema: public; Owner: nunezh
--

CREATE TABLE public.wages (
    wage_id integer NOT NULL,
    occupation_id integer,
    date date NOT NULL,
    state_id integer,
    hourly_mean_wage numeric(10,2),
    annual_mean_wage numeric(10,2),
    wage_rse numeric(5,2)
);


ALTER TABLE public.wages OWNER TO nunezh;

--
-- Name: wages_wage_id_seq; Type: SEQUENCE; Schema: public; Owner: nunezh
--

CREATE SEQUENCE public.wages_wage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wages_wage_id_seq OWNER TO nunezh;

--
-- Name: wages_wage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nunezh
--

ALTER SEQUENCE public.wages_wage_id_seq OWNED BY public.wages.wage_id;


--
-- Name: employment_data employment_id; Type: DEFAULT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.employment_data ALTER COLUMN employment_id SET DEFAULT nextval('public.employment_data_employment_id_seq'::regclass);


--
-- Name: occupations occupation_id; Type: DEFAULT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.occupations ALTER COLUMN occupation_id SET DEFAULT nextval('public.occupations_occupation_id_seq'::regclass);


--
-- Name: state_data state_id; Type: DEFAULT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.state_data ALTER COLUMN state_id SET DEFAULT nextval('public.state_data_state_id_seq'::regclass);


--
-- Name: wages wage_id; Type: DEFAULT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.wages ALTER COLUMN wage_id SET DEFAULT nextval('public.wages_wage_id_seq'::regclass);


--
-- Data for Name: employment_data; Type: TABLE DATA; Schema: public; Owner: nunezh
--

COPY public.employment_data (employment_id, occupation_id, date, state_id, employment, employment_rse) FROM stdin;
1	1	2022-09-19	1	50000	1.50
2	1	2020-06-11	2	30000	1.70
\.


--
-- Data for Name: occupations; Type: TABLE DATA; Schema: public; Owner: nunezh
--

COPY public.occupations (occupation_id, occupation_code, occupation_title, description) FROM stdin;
1	11-1021	General and Operations Managers	Plan, direct, or coordinate the operations of public or private sector organizations.
\.


--
-- Data for Name: state_data; Type: TABLE DATA; Schema: public; Owner: nunezh
--

COPY public.state_data (state_id, state_code, state_name) FROM stdin;
1	CA	California
2	TX	Texas
\.


--
-- Data for Name: wages; Type: TABLE DATA; Schema: public; Owner: nunezh
--

COPY public.wages (wage_id, occupation_id, date, state_id, hourly_mean_wage, annual_mean_wage, wage_rse) FROM stdin;
1	1	2022-09-19	1	50.75	105560.00	1.20
2	1	2020-06-11	2	48.20	100256.00	1.40
\.


--
-- Name: employment_data_employment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nunezh
--

SELECT pg_catalog.setval('public.employment_data_employment_id_seq', 1, false);


--
-- Name: occupations_occupation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nunezh
--

SELECT pg_catalog.setval('public.occupations_occupation_id_seq', 1, false);


--
-- Name: state_data_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nunezh
--

SELECT pg_catalog.setval('public.state_data_state_id_seq', 1, false);


--
-- Name: wages_wage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nunezh
--

SELECT pg_catalog.setval('public.wages_wage_id_seq', 1, false);


--
-- Name: employment_data employment_data_pkey; Type: CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.employment_data
    ADD CONSTRAINT employment_data_pkey PRIMARY KEY (employment_id);


--
-- Name: occupations occupations_pkey; Type: CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.occupations
    ADD CONSTRAINT occupations_pkey PRIMARY KEY (occupation_id);


--
-- Name: state_data state_data_pkey; Type: CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.state_data
    ADD CONSTRAINT state_data_pkey PRIMARY KEY (state_id);


--
-- Name: wages wages_pkey; Type: CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.wages
    ADD CONSTRAINT wages_pkey PRIMARY KEY (wage_id);


--
-- Name: employment_data employment_data_occupation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.employment_data
    ADD CONSTRAINT employment_data_occupation_id_fkey FOREIGN KEY (occupation_id) REFERENCES public.occupations(occupation_id);


--
-- Name: employment_data employment_data_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.employment_data
    ADD CONSTRAINT employment_data_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.state_data(state_id);


--
-- Name: wages wages_occupation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.wages
    ADD CONSTRAINT wages_occupation_id_fkey FOREIGN KEY (occupation_id) REFERENCES public.occupations(occupation_id);


--
-- Name: wages wages_state_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nunezh
--

ALTER TABLE ONLY public.wages
    ADD CONSTRAINT wages_state_id_fkey FOREIGN KEY (state_id) REFERENCES public.state_data(state_id);


--
-- PostgreSQL database dump complete
--

