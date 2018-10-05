SET client_min_messages TO WARNING;

DROP TABLE IF EXISTS api.components CASCADE;

CREATE TABLE api.components (
    id serial NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    taxonomy integer NOT NULL,
    status integer NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy) REFERENCES api.taxonomy (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS components_insert ON api.comments;

CREATE TRIGGER components_insert BEFORE INSERT ON api.components FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS components_update ON api.comments;

CREATE TRIGGER components_update BEFORE
UPDATE
    ON api.components FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.components TO web_anon;
