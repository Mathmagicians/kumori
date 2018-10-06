SET client_min_messages TO WARNING;

DROP TABLE IF EXISTS api.statuses CASCADE;

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT NOT NULL,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS statuses_insert ON api.comments;

CREATE TRIGGER statuses_insert BEFORE INSERT ON api.statuses FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS statuses_update ON api.comments;

CREATE TRIGGER statuses_update BEFORE
UPDATE
    ON api.statuses FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.statuses TO web_anon;
