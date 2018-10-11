SET client_min_messages TO WARNING;

DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'meritocracy') THEN
            CREATE ROLE meritocracy LOGIN PASSWORD 'meritocracy';
        COMMENT ON ROLE meritocracy IS 'This is the default CRUD user.';
    END IF;
END $body$;

DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'web_anon') THEN
            CREATE ROLE web_anon NOLOGIN;
        COMMENT ON ROLE web_anon IS 'This is the default anonymous user for read only access.';
    END IF;
END $body$;

GRANT web_anon TO meritocracy;
-- Create Database
DROP DATABASE IF EXISTS meritocracy;

CREATE DATABASE meritocracy ENCODING 'utf-8';

GRANT CONNECT ON DATABASE meritocracy TO meritocracy;

-- Connect Database
\connect meritocracy;

SET
client_min_messages TO WARNING;

-- Create Schema
DROP SCHEMA IF EXISTS api CASCADE;

CREATE SCHEMA api;

-- Create priviliges
GRANT USAGE ON SCHEMA api TO meritocracy;

GRANT USAGE ON SCHEMA api TO web_anon;

ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT ALL ON TABLES TO meritocracy;
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
DROP TABLE IF EXISTS api.taxonomy CASCADE;

CREATE TABLE api.taxonomy (
    id serial NOT NULL,
    name TEXT NOT NULL,
    level integer NOT NULL,
    parent TEXT,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS taxonomy_insert ON api.taxonomy;

CREATE TRIGGER taxonomy_insert BEFORE INSERT ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS taxonomy_update ON api.taxonomy;

CREATE TRIGGER taxonomy_update BEFORE
UPDATE
    ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.taxonomy TO web_anon;
DROP TABLE IF EXISTS api.statuses CASCADE;

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS statuses_insert ON api.statuses;

CREATE TRIGGER statuses_insert BEFORE INSERT ON api.statuses FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS statuses_update ON api.statuses;

CREATE TRIGGER statuses_update BEFORE
UPDATE
    ON api.statuses FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.statuses TO web_anon;
DROP TABLE IF EXISTS api.scopes CASCADE;

CREATE TABLE api.scopes (
    id serial NOT NULL,
    name TEXT NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS scopes_insert ON api.scopes;

CREATE TRIGGER scopes_insert BEFORE INSERT ON api.scopes FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS scopes_update ON api.scopes;

CREATE TRIGGER scopes_update BEFORE
UPDATE
    ON api.scopes FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.scopes TO web_anon;
DROP TABLE IF EXISTS api.components CASCADE;

CREATE TABLE api.components (
    id serial NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    status integer,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS components_insert ON api.components;

CREATE TRIGGER components_insert BEFORE INSERT ON api.components FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS components_update ON api.components;

CREATE TRIGGER components_update BEFORE
UPDATE
    ON api.components FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.components TO web_anon;
DROP TABLE IF EXISTS api.comments CASCADE;

CREATE TABLE api.comments (
    id serial NOT NULL,
    comment TEXT NOT NULL,
    component integer NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS comments_insert ON api.comments;

CREATE TRIGGER comments_insert BEFORE INSERT ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS comments_update ON api.comments;

CREATE TRIGGER comments_update BEFORE
UPDATE
    ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.comments TO web_anon;
DROP TABLE IF EXISTS api.links CASCADE;

CREATE TABLE api.links (
    id serial NOT NULL,
    ref TEXT NOT NULL,
    type TEXT,
    component integer NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS links_insert ON api.links;

CREATE TRIGGER links_insert BEFORE INSERT ON api.links FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS links_update ON api.links;

CREATE TRIGGER links_update BEFORE
UPDATE
    ON api.links FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.links TO web_anon;
DROP TABLE IF EXISTS api.usecases CASCADE;

CREATE TABLE api.usecases (
    id serial NOT NULL,
    component integer NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    scope integer,
    status integer,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT scope FOREIGN KEY (scope) REFERENCES api.scopes (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS usecases_insert ON api.usecases;

CREATE TRIGGER usecases_insert BEFORE INSERT ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS usecases_update ON api.usecases;

CREATE TRIGGER usecases_update BEFORE
UPDATE
    ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.usecases TO web_anon;
DROP TABLE IF EXISTS api.component_taxonomy CASCADE;

CREATE TABLE api.component_taxonomy (
    component integer NOT NULL,
    taxonomy integer NOT NULL,
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy) REFERENCES api.taxonomy (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT components FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.component_taxonomy TO web_anon;
DROP VIEW IF EXISTS api.w_usecases;

CREATE OR REPLACE VIEW api.w_usecases
AS
SELECT
    usecase.id,
    component.name AS component,
    usecase.description,
    status.name AS status,
    sco.name AS scope,
    to_char(usecase.modified,'YYYY-MM-DD') AS modified,
    usecase.modifiedby AS modifiedby,
    usecase.deleted AS deleted
FROM
    api.usecases usecase
    JOIN api.components component ON usecase.component = component.id
    JOIN api.statuses status ON usecase.status = status.id
    JOIN api.scopes sco ON usecase.scope = sco.id;

GRANT SELECT ON TABLE api.w_usecases TO web_anon;
DROP VIEW IF EXISTS api.w_components;

CREATE OR REPLACE VIEW api.w_components
AS
SELECT
    MD5(COALESCE(component.name, '') || COALESCE(component.description, '')) AS uid,
    component.name as name,
    status.name as status,
    component.description,
    (
        SELECT array_to_json(array_agg(co.comment))
        FROM api.comments AS co
        WHERE co.component = component.id
    ) as comments,
    (
        SELECT array_to_json(array_agg(tx.name))
        FROM api.component_taxonomy AS ct
        JOIN api.taxonomy AS tx ON ct.taxonomy = tx.id
        WHERE ct.component = component.id
    ) as tags,
    json_build_array() AS licenses,
    (
      SELECT array_to_json(array_agg(json_build_object(
        'type',co.type,
        'ref',co.ref)))
      FROM api.links AS co
      WHERE co.component = component.id
    ) AS links,
    (
      SELECT array_to_json(array_agg(json_build_object(
        'name',us.name,
        'description',us.description,
        'status',status.name,
        'scope',sco.name)))
      FROM api.usecases AS us
          JOIN api.statuses status ON us.status = status.id
          JOIN api.scopes sco ON us.scope = sco.id
      WHERE us.component = component.id
    ) AS usecases
FROM
    api.components component
JOIN api.statuses status ON component.status = status.id;

GRANT SELECT ON TABLE api.w_components TO web_anon;
DROP VIEW IF EXISTS api.w_taxonomy;

CREATE OR REPLACE VIEW api.w_taxonomy
AS
SELECT
    JSON_BUILD_OBJECT('name', 'TBM Service Taxonomy', 'levels', JSON_BUILD_ARRAY(JSON_BUILD_OBJECT('level', 1, 'name', 'Type'), JSON_BUILD_OBJECT('level', 2, 'name', 'Category'), JSON_BUILD_OBJECT('level', 3, 'name', 'Name'), JSON_BUILD_OBJECT('level', 4, 'name', 'Capability'), JSON_BUILD_OBJECT('level', 5, 'name', 'Use Case')), 'tags', ARRAY_TO_JSON(ARRAY_AGG(JSON_BUILD_OBJECT('id', taxonomy.id, 'level', taxonomy.level, 'name', taxonomy.name, 'parent', taxonomy.parent)))) AS taxonomy
FROM
    api.taxonomy taxonomy;

GRANT SELECT ON TABLE api.w_taxonomy TO web_anon;
