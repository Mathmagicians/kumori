DROP TABLE IF EXISTS api.scopes CASCADE;

CREATE TABLE api.scopes (
    id serial NOT NULL,
    name TEXT NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS scopes_insert ON api.scopes;

CREATE TRIGGER scopes_insert BEFORE INSERT ON api.scopes FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS scopes_update ON api.scopes;

CREATE TRIGGER scopes_update BEFORE
UPDATE
    ON api.scopes FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.scopes TO web_anon;
