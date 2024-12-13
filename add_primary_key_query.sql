-- Created by Nicholas Littlefield

CREATE or REPLACE FUNCTION add_prim_key() RETURNS void
LANGUAGE plpgsql
as $$
	begin

		if NOT exists (select constraint_name from information_schema.table_constraints where table_name = 'occupations' and constraint_type = 'PRIMARY KEY') then

			ALTER TABLE occupations
  			ADD PRIMARY KEY (occupation_id);

		end if;

	end;
$$;
