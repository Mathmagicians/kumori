DROP TABLE IF EXISTS api.usecase_taxonomy CASCADE;

CREATE TABLE api.usecase_taxonomy (
    usecase integer NOT NULL,
    taxonomy integer NOT NULL,
    CONSTRAINT taxonomy FOREIGN KEY (taxonomy) REFERENCES api.taxonomy (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT usecases FOREIGN KEY (usecase) REFERENCES api.usecases (id)
        MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

GRANT SELECT ON api.usecase_taxonomy TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.usecase_taxonomy to editor;
