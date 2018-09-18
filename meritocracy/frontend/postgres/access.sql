DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'meritocracy') THEN
            CREATE ROLE techmenu LOGIN PASSWORD 'meritocracy';
    END IF;
END $body$;

GRANT CONNECT ON DATABASE meritocracy TO meritocracy;

\c techmenu;
GRANT USAGE ON SCHEMA public TO meritocracy;
/*
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO meritocracy;
*/
GRANT UPDATE(data) ON components TO meritocracy;
GRANT SELECT(id,data) ON components TO meritocracy;
\q
