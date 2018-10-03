SET client_min_messages TO WARNING;
DROP TABLE IF EXISTS api.usecases CASCADE;
CREATE TABLE api.usecases
(
    id serial NOT NULL,
    taxonomy integer NOT NULL,
    description text  NOT NULL,
    scope integer NOT NULL,
    status integer NOT NULL,
    modified timestamp without time zone NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy)
    REFERENCES api.taxonomy (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT scope FOREIGN KEY (scope)
    REFERENCES api.scopes (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    CONSTRAINT status FOREIGN KEY (status)
    REFERENCES api.statuses (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS usecases_insert ON api.comments;
CREATE TRIGGER usecases_insert BEFORE INSERT
  ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS usecases_update ON api.comments;
CREATE TRIGGER usecases_update BEFORE UPDATE
  ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT (id, taxonomy, description, scope, status, modified, deleted) ON api.usecases TO web_anon;
