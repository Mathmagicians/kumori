DROP VIEW IF EXISTS api.w_simple_components;

CREATE OR REPLACE VIEW api.w_simple_components
AS
SELECT c.id, c.name, c.description,
( SELECT json_build_object(
  'id',cu.status,
  'name',s.name,
  'phase',s.phase)
  FROM api.component_usecase AS cu
  LEFT JOIN api.statuses AS s ON cu.status = s.id
  WHERE cu.usecase = c.primary_usecase ) AS primary_usecase
FROM api.components AS c;

GRANT SELECT ON TABLE api.w_simple_components TO web_anon;
GRANT SELECT ON TABLE api.w_simple_components TO editor;
