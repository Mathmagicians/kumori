DROP TABLE IF EXISTS api.comments CASCADE;

CREATE TABLE api.comments (
    id serial NOT NULL,
    comment TEXT NOT NULL,
    component integer NOT NULL,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT component FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

DROP TRIGGER IF EXISTS comments_insert ON api.comments;

CREATE TRIGGER comments_insert BEFORE INSERT ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

DROP TRIGGER IF EXISTS comments_update ON api.comments;

CREATE TRIGGER comments_update BEFORE
UPDATE
    ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.comments TO web_anon;
GRANT ALL ON api.comments to editor;
GRANT USAGE, SELECT ON SEQUENCE api.comments_id_seq TO editor;
