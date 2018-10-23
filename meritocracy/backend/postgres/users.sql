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

DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'editor') THEN
            CREATE ROLE editor NOLOGIN;
        COMMENT ON ROLE editor IS 'This is a editor user with CRUD.';
    END IF;
END $body$;

GRANT web_anon TO meritocracy;
GRANT editor TO meritocracy;
