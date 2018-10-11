DROP TABLE IF EXISTS api.taxonomy CASCADE;

CREATE TABLE api.taxonomy (
    id serial NOT NULL,
    name TEXT NOT NULL,
    level integer NOT NULL,
    parent TEXT,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS taxonomy_insert ON api.taxonomy;

CREATE TRIGGER taxonomy_insert BEFORE INSERT ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS taxonomy_update ON api.taxonomy;

CREATE TRIGGER taxonomy_update BEFORE
UPDATE
    ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.taxonomy TO web_anon;
