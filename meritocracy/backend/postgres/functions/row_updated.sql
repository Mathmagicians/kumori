SET client_min_messages TO WARNING;

DROP FUNCTION IF EXISTS row_updated ()
    CASCADE;

CREATE FUNCTION row_updated ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.* != OLD.* THEN
        NEW.modified := LOCALTIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$;
