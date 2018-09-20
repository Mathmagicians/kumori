-- Create Users
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

CREATE DATABASE meritocracy;

GRANT CONNECT ON DATABASE meritocracy TO meritocracy;

-- Connect Database
\connect meritocracy;

-- Create Schema
DROP
SCHEMA IF EXISTS api;

CREATE SCHEMA api;

-- Create Table
DROP TABLE IF EXISTS api.components;

CREATE TABLE api.components (
    id serial PRIMARY KEY,
    data jsonb,
    modified TIMESTAMP NOT NULL
);

-- Create Functions
DROP FUNCTION IF EXISTS data_changed ();

CREATE FUNCTION data_changed ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.data != OLD.data THEN
        NEW.modified := LOCALTIMESTAMP;
        RAISE NOTICE 'modified updated for components ''%'' on %', OLD.id, NEW.modified;
    END IF;
    RETURN NEW;
END;
$$;

DROP FUNCTION IF EXISTS data_inserted ();

CREATE FUNCTION data_inserted ()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    NEW.modified := LOCALTIMESTAMP;
    RAISE NOTICE 'modified created for components ''%'' on %', new.id, NEW.modified;
    RETURN NEW;
END;
$$;

-- Create Trigger
DROP TRIGGER IF EXISTS trigger_data_changed ON api.components;

CREATE TRIGGER trigger_data_changed BEFORE
UPDATE
    ON api.components FOR EACH ROW EXECUTE PROCEDURE data_changed ();

CREATE TRIGGER trigger_data_inserted BEFORE INSERT ON api.components FOR EACH ROW EXECUTE PROCEDURE data_inserted ();

-- Create priviliges
GRANT USAGE ON SCHEMA api TO meritocracy;

GRANT USAGE ON SCHEMA api TO web_anon;

ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT ALL ON TABLES TO meritocracy;

GRANT UPDATE (data)
ON api.components TO web_anon;

GRANT SELECT (id, data, modified)
ON api.components TO web_anon;

-- Disconnect Database
\q
