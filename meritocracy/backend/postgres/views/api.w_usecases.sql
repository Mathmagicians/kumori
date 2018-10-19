DROP VIEW IF EXISTS api.w_usecases;

CREATE OR REPLACE VIEW api.w_usecases
AS
SELECT
    usecase.id,
    component.name AS component,
    usecase.description,
    status.name AS status,
    sco.name AS scope,
    to_char(usecase.modified,'YYYY-MM-DD') AS modified,
    usecase.deleted AS deleted
FROM
    api.usecases usecase
    JOIN api.components component ON usecase.component = component.id
    JOIN api.statuses status ON usecase.status = status.id
    JOIN api.scopes sco ON usecase.scope = sco.id;

GRANT SELECT ON TABLE api.w_usecases TO web_anon;
GRANT ALL ON api.w_usecases to editor;
