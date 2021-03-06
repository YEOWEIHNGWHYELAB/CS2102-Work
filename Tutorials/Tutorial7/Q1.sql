CREATE OR REPLACE FUNCTION not_manager()
RETURNS TRIGGER AS $$
DECLARE 
	count_s INTEGER := 0;
BEGIN 
	SELECT COUNT(*) INTO count_s
	FROM Managers m
	WHERE NEW.eid = m.eid;
	
	IF (count_s > 0 ) THEN 
		RETURN NULL;
	ELSE 
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_manager
BEFORE INSERT OR UPDATE ON Engineers
FOR EACH ROW EXECUTE FUNCTION not_manager();