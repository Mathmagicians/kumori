DROP TABLE IF EXISTS api.statuses CASCADE;

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.statuses TO web_anon;
