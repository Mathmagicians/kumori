DROP TABLE IF EXISTS components;

CREATE TABLE components (
    id serial primary key,
    data jsonb,
    last_modified DATE NOT NULL
);

DROP FUNCTION IF EXISTS data_changed();

CREATE FUNCTION data_changed() RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.data != OLD.data THEN
    NEW.last_modified := current_date;
    RAISE NOTICE 'last_modified updated for components ''%'' on %', OLD.id, NEW.last_modified;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trigger_data_changed ON components;

CREATE TRIGGER trigger_data_changed
  BEFORE UPDATE ON components
  FOR EACH ROW
  EXECUTE PROCEDURE data_changed();
