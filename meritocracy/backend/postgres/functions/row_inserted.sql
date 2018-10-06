SET client_min_messages TO WARNING;

DROP FUNCTION IF EXISTS row_inserted ()
    CASCADE;

CREATE FUNCTION row_inserted ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    NEW.modified := LOCALTIMESTAMP;
    RETURN NEW;
END;
$$;
