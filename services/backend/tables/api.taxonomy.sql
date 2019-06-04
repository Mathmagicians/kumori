DROP TABLE IF EXISTS api.taxonomy CASCADE;

CREATE TABLE api.taxonomy (
    id serial NOT NULL,
    name TEXT NOT NULL,
    level integer NOT NULL,
    parent integer,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.taxonomy TO web_anon;
GRANT SELECT ON api.taxonomy TO editor;
