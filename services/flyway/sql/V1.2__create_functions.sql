CREATE FUNCTION public.row_inserted ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    NEW.modified := LOCALTIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE FUNCTION public.row_updated ()
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
