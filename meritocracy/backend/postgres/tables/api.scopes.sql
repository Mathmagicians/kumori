DROP TABLE IF EXISTS api.scopes CASCADE;

CREATE TABLE api.scopes (
    id serial NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.scopes TO web_anon;
