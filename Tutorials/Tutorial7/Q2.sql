CREATE OR REPLACE FUNCTION budget_check()
RETURNS TRIGGER AS $$
DECLARE 
	hrs INTEGER; -- Total work hours before the current update/insertion.
	bgt INTEGER; -- Total budget of the particular project.
	rst INTEGER; -- Remaining work hour a project has. 
BEGIN 
	SELECT COALESCE(SUM(w.hours), 0) INTO hrs
	FROM Works w
	WHERE w.pid = NEW.pid
		AND w.eid <> NEW.eid;
		
	SELECT p.pbuget INTO bgt
	FROM Projects p
	WHERE NEW.pid = p.pid;
	
	rst := ((bgt/100) - hrs);
	
	IF rst < NEW.hours THEN 
		RETURN (NEW.pid, NEW.eid, NEW.wid, rst);
	ELSE 
		RETURN NEW;
	END IF;
	
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER budget_no_exceed
BEFORE INSERT OR UPDATE ON Works
FOR EACH ROW EXECUTE FUNCTION budget_check();
