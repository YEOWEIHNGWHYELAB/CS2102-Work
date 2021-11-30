CREATE OR REPLACE FUNCTION max_hour()
RETURNS TRIGGER AS $$
DECLARE 
	max_hr INTEGER;
BEGIN
	SELECT max_hours INTO max_hr
	FROM Works w
	WHERE w.wid = NEW.wid;
	
	IF (NEW.hours > max_hr) THEN 
		RETURN (NEW.pid, NEW.eid, NEW.wid, max_hr);
	ELSE 
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER hours_max
BEFORE UPDATE OR INSERT ON Works
FOR EACH ROW EXECUTE FUNCTION max_hour();