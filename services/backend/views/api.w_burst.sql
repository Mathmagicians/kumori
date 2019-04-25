DROP VIEW IF EXISTS api.w_burst;

CREATE OR REPLACE VIEW api.w_burst
AS
SELECT
    id,
    name,
    level,
    parent,
    (
      SELECT
        COUNT(*)
      FROM api.usecases
      LEFT JOIN api.usecase_taxonomy ON api.usecases.id = api.usecase_taxonomy.usecase
      WHERE api.usecase_taxonomy.taxonomy = tax.id) AS size,
      ( CASE
          WHEN (
            SELECT ARRAY_TO_JSON(ARRAY_AGG(api.taxonomy.name))
            FROM api.taxonomy
            WHERE parent = tax.name) IS NULL
          THEN (JSON_BUILD_ARRAY())
          ELSE (
            SELECT
            ARRAY_TO_JSON(ARRAY_AGG(api.taxonomy.name))
            FROM
            api.taxonomy
            WHERE
            parent = tax.name)
          END) AS children
FROM
    api.taxonomy AS tax;

GRANT SELECT ON TABLE api.w_burst TO web_anon;

GRANT SELECT ON TABLE api.w_burst TO editor;
