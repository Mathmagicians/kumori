DROP TABLE IF EXISTS api.scopes CASCADE;

CREATE TABLE api.scopes (
    id serial NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.scopes TO web_anon;
GRANT ALL ON api.scopes to editor;
GRANT USAGE, SELECT ON SEQUENCE api.scopes_id_seq TO editor;
