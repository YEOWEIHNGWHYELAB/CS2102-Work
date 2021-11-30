CREATE OR REPLACE FUNCTION default_work()
RETURN TRIGGER AS $$
BEGIN
	RAISE NOTICE 'Some user tried to modify/delete';
	RAISE NOTICE 'default worktype';
	RETURN NULL;
END;
$$LANGUAGE plpgsql;

CREATE TRIGGER work_default
BEFORE UPDATE OR DELETE ON WorkType
FOR EACH ROW WHEN (OLD.wid = 0) EXECUTE FUNCTION default_work(); 