DROP TABLE IF EXISTS api.component_usecase CASCADE;

CREATE TABLE api.component_usecase (
    component integer NOT NULL,
    usecase integer NOT NULL,
    CONSTRAINT usecases FOREIGN KEY (usecase) REFERENCES api.usecases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT components FOREIGN KEY (component) REFERENCES api.components (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.component_usecase TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.component_usecase to editor;
