DROP TABLE IF EXISTS api.phases CASCADE;

CREATE TABLE api.phases (
    id serial NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.phases TO web_anon;
GRANT SELECT ON api.phases TO editor;
