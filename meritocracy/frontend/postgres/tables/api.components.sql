SET client_min_messages TO WARNING;
DROP TABLE IF EXISTS api.components CASCADE;
CREATE TABLE api.components
(
    id serial NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    modified timestamp without time zone NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS components_insert ON api.comments;
CREATE TRIGGER components_insert BEFORE INSERT
  ON api.components FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS components_update ON api.comments;
CREATE TRIGGER components_update BEFORE UPDATE
  ON api.components FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT (id, name, description, modified, deleted) ON api.components TO web_anon;
