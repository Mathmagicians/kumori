DROP TABLE IF EXISTS api.statuses CASCADE;

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.statuses TO web_anon;
GRANT ALL ON api.statuses to editor;
GRANT USAGE, SELECT ON SEQUENCE api.statuses_id_seq TO editor;
