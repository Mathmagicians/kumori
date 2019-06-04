DROP TABLE IF EXISTS api.statuses CASCADE;

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    phase integer NOT NULL,
    description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT phase FOREIGN KEY (phase) REFERENCES api.phases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.statuses TO web_anon;
GRANT SELECT ON api.statuses TO editor;
