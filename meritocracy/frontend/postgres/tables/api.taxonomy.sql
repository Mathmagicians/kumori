SET client_min_messages TO WARNING;
DROP TABLE IF EXISTS api.taxonomy CASCADE;

CREATE TABLE api.taxonomy
(
    id serial NOT NULL,
    name text NOT NULL,
    level integer NOT NULL,
    parent text,
    modified timestamp without time zone NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS taxonomy_insert ON api.comments;
CREATE TRIGGER taxonomy_insert BEFORE INSERT
  ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS taxonomy_update ON api.comments;
CREATE TRIGGER taxonomy_update BEFORE UPDATE
  ON api.taxonomy FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT (name, level, parent) ON api.taxonomy TO web_anon;
