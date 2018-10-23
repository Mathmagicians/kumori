DROP TABLE IF EXISTS api.components CASCADE;

CREATE TABLE api.components (
    id serial NOT NULL,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    status integer,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS components_insert ON api.components;

CREATE TRIGGER components_insert BEFORE INSERT ON api.components FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS components_update ON api.components;

CREATE TRIGGER components_update BEFORE
UPDATE
    ON api.components FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.components TO web_anon;
GRANT ALL ON api.components to editor;
GRANT USAGE, SELECT ON SEQUENCE api.components_id_seq TO editor;
