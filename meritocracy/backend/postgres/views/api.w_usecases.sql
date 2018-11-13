DROP VIEW IF EXISTS api.w_usecases;

CREATE OR REPLACE VIEW api.w_usecases
AS
SELECT
    usecase.id,
    usecase.description,
    sco.name AS scope,
    to_char(usecase.modified,'YYYY-MM-DD') AS modified,
    usecase.deleted AS deleted
FROM
    api.usecases usecase
    JOIN api.scopes sco ON usecase.scope = sco.id;

GRANT SELECT ON TABLE api.w_usecases TO web_anon;
GRANT SELECT ON TABLE api.w_usecases TO editor;
