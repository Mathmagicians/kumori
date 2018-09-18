DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'meritocracy') THEN
            CREATE ROLE meritocracy LOGIN PASSWORD 'meritocracy';
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
    END IF;
END $body$;

GRANT CONNECT ON DATABASE meritocracy TO meritocracy;
GRANT CONNECT ON DATABASE meritocracy TO web_anon;

\c meritocracy;
GRANT USAGE ON SCHEMA public TO meritocracy;
GRANT USAGE ON SCHEMA public TO web_anon;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO meritocracy;
GRANT UPDATE(data) ON components TO web_anon;
GRANT SELECT(id,data,last_modified) ON components TO web_anon;
\q
