DROP TABLE IF EXISTS api.usecases CASCADE;

CREATE TABLE api.usecases (
    id serial NOT NULL,
    component integer NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    scope integer,
    status integer,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT scope FOREIGN KEY (scope) REFERENCES api.scopes (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS usecases_insert ON api.usecases;

CREATE TRIGGER usecases_insert BEFORE INSERT ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS usecases_update ON api.usecases;

CREATE TRIGGER usecases_update BEFORE
UPDATE
    ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.usecases TO web_anon;
