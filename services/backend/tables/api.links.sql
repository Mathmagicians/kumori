DROP TABLE IF EXISTS api.links CASCADE;

CREATE TABLE api.links (
    id serial NOT NULL,
    ref TEXT NOT NULL,
    type TEXT,
    component integer NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS links_insert ON api.links;

CREATE TRIGGER links_insert BEFORE INSERT ON api.links FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS links_update ON api.links;

CREATE TRIGGER links_update BEFORE
UPDATE
    ON api.links FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.links TO web_anon;
GRANT ALL ON api.links to editor;
GRANT USAGE, SELECT ON SEQUENCE api.links_id_seq TO editor;
