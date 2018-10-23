DROP TABLE IF EXISTS api.component_taxonomy CASCADE;

CREATE TABLE api.component_taxonomy (
    component integer NOT NULL,
    taxonomy integer NOT NULL,
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy) REFERENCES api.taxonomy (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT components FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.component_taxonomy TO web_anon;
GRANT ALL ON api.component_taxonomy to editor;
