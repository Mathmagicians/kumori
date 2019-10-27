-- DROP
DROP VIEW api.usecases;

-- CREATE TABLES
CREATE TABLE public.usecase_status (
    usecase integer NOT NULL,
    status integer NOT NULL,
    CONSTRAINT status FOREIGN KEY (status) REFERENCES public.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT usecases FOREIGN KEY (usecase) REFERENCES public.usecases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    PRIMARY KEY (usecase,status)
);

CREATE TABLE public.usecase_revisions (
    usecase_id BIGINT NOT NULL REFERENCES public.usecases (id),
    created_at TIMESTAMP WITHOUT TIME ZONE,
    created_by TEXT,
    name TEXT,
    description TEXT,
    PRIMARY KEY (usecase_id,
        name,
        created_at)
);

-- ALTER TABLES
ALTER TABLE public.usecases RENAME COLUMN modified TO created_at;
ALTER TABLE public.usecases RENAME COLUMN modifiedby TO updated_by;
ALTER TABLE public.usecases DROP COLUMN deleted;
ALTER TABLE public.usecases ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE public.usecases ALTER COLUMN created_at SET DEFAULT NOW();
ALTER TABLE public.usecases ALTER COLUMN created_at DROP NOT NULL;

-- FUNCTIONS
CREATE OR REPLACE FUNCTION public.on_usecase_insert ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    new.updated_at := LOCALTIMESTAMP;
    new.updated_by := CURRENT_USER;
    RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.on_usecase_update ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $body$
BEGIN
    IF old.name <> new.name OR old.description <> new.description THEN
        IF old.updated_at IS NULL THEN
            INSERT INTO public.usecase_revisions (usecase_id, created_at, created_by, name, description)
            VALUES (old.id, old.created_at, old.updated_by, old.name, old.description);
        ELSE
            INSERT INTO public.usecase_revisions (usecase_id, created_at, created_by, name, description)
            VALUES (old.id, old.updated_at, old.updated_by, old.name, old.description);
        END IF;
        NEW.updated_at := LOCALTIMESTAMP;
        new.updated_by := CURRENT_USER;
    END IF;
    RETURN new;
END;
$body$;

CREATE OR REPLACE FUNCTION public.on_usecase_delete ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $body$
BEGIN
    DELETE FROM public.usecase_revisions
    WHERE usecase_id = old.id;
    RETURN old;
END;
$body$;

-- TRIGGERS
DROP TRIGGER usecases_insert ON public.usecases;

DROP TRIGGER usecases_update ON public.usecases;

CREATE TRIGGER usecase_delete BEFORE DELETE ON public.usecases FOR EACH row EXECUTE PROCEDURE public.on_usecase_delete ();

CREATE TRIGGER usecase_revision BEFORE
UPDATE
    ON public.usecases FOR EACH row EXECUTE PROCEDURE public.on_usecase_update ();

CREATE TRIGGER usecase_insert BEFORE INSERT ON public.usecases FOR EACH row EXECUTE PROCEDURE public.on_usecase_insert ();

-- VIEWS
CREATE VIEW api.usecase_revisions
AS
SELECT
usecase_id,
created_at,
created_by,
name,
description
FROM
    public.usecase_revisions;

CREATE VIEW api.usecases
AS
SELECT
    usecases.id AS id,
    name,
    description,
    created_at,
    updated_by,
    updated_at,
    ( SELECT COUNT(*) FROM public.usecase_revisions
      WHERE usecase_id = usecases.id
    ) AS revisions,
    ( CASE WHEN 0 <
      (
        SELECT COUNT(cous.usecase) FROM public.component_usecase AS cous
        WHERE cous.usecase = usecases.id
      ) THEN
      ( SELECT ARRAY_TO_JSON(
               ARRAY_AGG(
               JSON_BUILD_OBJECT(
                 'id', cous.component,
                 'name', comp.name))
               )
        FROM public.component_usecase AS cous
        LEFT JOIN public.components AS comp ON comp.id = cous.component
        WHERE cous.usecase = usecases.id
      ) ELSE
      ( JSON_BUILD_ARRAY()
      ) END) AS components,
      ( CASE WHEN 0 < (
            SELECT COUNT(usecase)
            FROM public.usecase_status
            WHERE usecase = usecases.id
      ) THEN
      ( SELECT JSON_BUILD_OBJECT('status', status.name, 'phase', phase.name)
        FROM public.usecase_status AS usecasest
        LEFT JOIN public.statuses AS status ON status.id = usecasest.status
        LEFT JOIN public.phases AS phase ON phase.id = status.phase
        WHERE usecasest.usecase = usecases.id
      ) ELSE
      ( SELECT JSON_BUILD_OBJECT('status', status.name, 'phase', phase.name)
        FROM public.statuses AS status
        LEFT JOIN public.phases AS phase ON phase.id = status.phase
        WHERE status.id = 1)
      END) AS status
FROM
    public.usecases;

-- GRANTS
GRANT SELECT ON public.usecase_status TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.usecase_status to editor;

GRANT SELECT ON api.usecases TO web_anon;
GRANT ALL ON api.usecases TO editor;

GRANT SELECT ON api.usecase_revisions TO web_anon;
GRANT ALL ON api.usecase_revisions TO editor;
GRANT SELECT ON public.usecase_revisions TO web_anon;
GRANT ALL ON public.usecase_revisions TO editor;
