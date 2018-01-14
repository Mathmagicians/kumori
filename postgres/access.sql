DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'grafana') THEN
            CREATE ROLE grafana LOGIN PASSWORD 'grafana';
    END IF;
END $body$;
DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'parser') THEN
            CREATE ROLE parser LOGIN PASSWORD 'parser';
    END IF;
END $body$;

DO $body$
BEGIN
    IF NOT EXISTS (
            SELECT
            FROM
                pg_catalog.pg_user
            WHERE
                usename = 'sonarqube') THEN
            CREATE ROLE sonarqube LOGIN PASSWORD 'sonarqube';
    END IF;
END $body$;

GRANT CONNECT ON DATABASE calculated TO grafana;
GRANT CONNECT ON DATABASE calculated TO parser;
GRANT CONNECT ON DATABASE sonarqube TO sonarqube;
GRANT CONNECT ON DATABASE sonarqube TO grafana;
GRANT CONNECT ON DATABASE raw TO parser;

\c calculated;
GRANT USAGE ON SCHEMA public TO grafana;
GRANT USAGE ON SCHEMA public TO parser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grafana;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO parser;
\q
\c raw;
GRANT USAGE ON SCHEMA public TO grafana;
GRANT USAGE ON SCHEMA public TO parser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grafana;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO parser;
\q
\c sonarqube
GRANT USAGE ON SCHEMA public TO sonarqube;
GRANT USAGE ON SCHEMA public TO grafana;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO grafana;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO sonarqube;
