-- Taxonomy

CREATE TABLE api.taxonomy (
    id serial NOT NULL,
    name TEXT NOT NULL,
    level integer NOT NULL,
    parent integer,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.taxonomy TO web_anon;
GRANT SELECT ON api.taxonomy TO editor;


-- Phases


CREATE TABLE api.phases (
    id serial NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    PRIMARY KEY (id)
);

GRANT SELECT ON api.phases TO web_anon;
GRANT SELECT ON api.phases TO editor;

-- Statuses

CREATE TABLE api.statuses (
    id serial NOT NULL,
    name TEXT NOT NULL,
    phase integer NOT NULL,
    description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT phase FOREIGN KEY (phase) REFERENCES api.phases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.statuses TO web_anon;
GRANT SELECT ON api.statuses TO editor;


-- Components

CREATE TABLE api.components (
    id serial NOT NULL,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    primary_usecase integer,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL DEFAULT false,
    PRIMARY KEY (id)
);

CREATE TRIGGER components_insert BEFORE INSERT ON api.components FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

CREATE TRIGGER components_update BEFORE
UPDATE
    ON api.components FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.components TO web_anon;
GRANT ALL ON api.components to editor;
GRANT USAGE, SELECT ON SEQUENCE api.components_id_seq TO editor;

-- Comments

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

CREATE TRIGGER comments_insert BEFORE INSERT ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

CREATE TRIGGER comments_update BEFORE
UPDATE
    ON api.comments FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.comments TO web_anon;
GRANT ALL ON api.comments to editor;
GRANT USAGE, SELECT ON SEQUENCE api.comments_id_seq TO editor;


-- Links

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

CREATE TRIGGER links_insert BEFORE INSERT ON api.links FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

CREATE TRIGGER links_update BEFORE
UPDATE
    ON api.links FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.links TO web_anon;
GRANT ALL ON api.links to editor;
GRANT USAGE, SELECT ON SEQUENCE api.links_id_seq TO editor;

-- Usecases

CREATE TABLE api.usecases (
    id serial NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    modified TIMESTAMP without TIME zone NOT NULL,
    modifiedby TEXT,
    deleted boolean NOT NULL DEFAULT false,
    PRIMARY KEY (id)
);

CREATE TRIGGER usecases_insert BEFORE INSERT ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_inserted ();

CREATE TRIGGER usecases_update BEFORE
UPDATE
    ON api.usecases FOR EACH ROW EXECUTE PROCEDURE row_updated ();

GRANT SELECT ON api.usecases TO web_anon;
GRANT ALL ON api.usecases to editor;
GRANT USAGE, SELECT ON SEQUENCE api.usecases_id_seq TO editor;


-- Usecase-taxonomy

CREATE TABLE api.usecase_taxonomy (
    usecase integer NOT NULL,
    taxonomy integer NOT NULL,
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy) REFERENCES api.taxonomy (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT usecases FOREIGN KEY (usecase) REFERENCES api.usecases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    PRIMARY KEY (usecase,taxonomy)
);

GRANT SELECT ON api.usecase_taxonomy TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.usecase_taxonomy to editor;


-- Component-usecase


CREATE TABLE api.component_usecase (
    component integer NOT NULL,
    usecase integer NOT NULL,
    status integer,
    description TEXT,
    CONSTRAINT usecases FOREIGN KEY (usecase) REFERENCES api.usecases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT components FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT status FOREIGN KEY (status) REFERENCES api.statuses (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    PRIMARY KEY (component,usecase)
);

GRANT SELECT ON api.component_usecase TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.component_usecase to editor;
