CREATE SCHEMA api;

-- Create priviliges
GRANT USAGE ON SCHEMA api TO ${dbrole};
GRANT USAGE ON SCHEMA api TO web_anon;
GRANT usage ON SCHEMA api TO editor;

ALTER DEFAULT PRIVILEGES IN SCHEMA api GRANT ALL ON TABLES TO ${dbrole};
