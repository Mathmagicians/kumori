-- DROP
DROP VIEW api.components;
-- ALTER TABLES
ALTER TABLE public.components RENAME COLUMN modified TO created_at;
ALTER TABLE public.components RENAME
 COLUMN modifiedby TO updated_by;
ALTER TABLE public.components DROP COLUMN deleted;
ALTER TABLE public.components ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE public.components ALTER COLUMN created_at SET DEFAULT NOW();
ALTER TABLE public.components ALTER COLUMN created_at DROP NOT NULL;
-- FUNCTIONS
CREATE OR REPLACE FUNCTION public.on_components_insert ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    new.updated_at := LOCALTIMESTAMP;
    new.updated_by := CURRENT_USER;
    RETURN NEW;
END;
$$;
CREATE OR REPLACE FUNCTION public.on_components_update ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $body$
BEGIN
    IF old.name <> new.name OR old.description <> new.description OR old.primary_usecase <> new.primary_usecase THEN
        IF old.updated_at IS NULL THEN
            INSERT INTO public.components_revisions (component_id, created_at, created_by, name, description, primary_usecase)
            VALUES (old.id, old.created_at, old.updated_by, old.name, old.description, old.primary_usecase);
        ELSE
            INSERT INTO public.components_revisions (component_id, created_at, created_by, name, description, primary_usecase)
            VALUES (old.id, old.updated_at, old.updated_by, old.name, old.description, old.primary_usecase);
        END IF;
        NEW.updated_at := LOCALTIMESTAMP;
        new.updated_by := CURRENT_USER;
    END IF;
    RETURN new;
END;
$body$;
CREATE OR REPLACE FUNCTION public.on_components_delete ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $body$
BEGIN
    DELETE FROM public.components_revisions
    WHERE component_id = old.id;
    RETURN old;
END;
$body$;
-- TRIGGERS
DROP TRIGGER components_insert ON public.components;

DROP TRIGGER components_update ON public.components;

CREATE TRIGGER components_delete BEFORE DELETE ON public.components FOR EACH row EXECUTE PROCEDURE public.on_components_delete ();

CREATE TRIGGER components_revision BEFORE
UPDATE
    ON public.components FOR EACH row EXECUTE PROCEDURE public.on_components_update ();

CREATE TRIGGER components_insert BEFORE INSERT ON public.components FOR EACH row EXECUTE PROCEDURE public.on_components_insert ();
-- TABLES
CREATE TABLE public.components_revisions (
    component_id BIGINT NOT NULL REFERENCES public.components (id),
    created_at TIMESTAMP WITHOUT TIME ZONE,
    created_by TEXT,
    name TEXT,
    description TEXT,
    primary_usecase INTEGER,
    PRIMARY KEY (component_id,
        name,
        created_at)
);
-- VIEWS
CREATE VIEW api.components_revisions
AS
SELECT
component_id,
created_at,
created_by,
name,
description,
primary_usecase
FROM
    public.components_revisions;

CREATE VIEW api.components
AS
SELECT
    id,
    name,
    description,
    primary_usecase,
    created_at,
    updated_by,
    updated_at,
    (SELECT COUNT(*) FROM public.components_revisions WHERE component_id = id) AS revisions
FROM
    public.components;

-- GRANTS
GRANT SELECT ON api.components TO web_anon;
GRANT ALL ON api.components TO editor;
GRANT SELECT ON api.components_revisions TO web_anon;
GRANT ALL ON api.components_revisions TO editor;
GRANT SELECT ON public.components_revisions TO web_anon;
GRANT ALL ON public.components_revisions TO editor;
