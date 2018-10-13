DROP VIEW IF EXISTS api.w_taxonomy;

CREATE OR REPLACE VIEW api.w_taxonomy
AS
SELECT
    'TBM Service Taxonomy' AS name,
    JSON_BUILD_ARRAY(
      JSON_BUILD_OBJECT('level', 1, 'name', 'Type'),
      JSON_BUILD_OBJECT('level', 2, 'name', 'Category'),
      JSON_BUILD_OBJECT('level', 3, 'name', 'Name'),
      JSON_BUILD_OBJECT('level', 4, 'name', 'Capability'), JSON_BUILD_OBJECT('level', 5, 'name', 'Use Case')) AS levels,
    ARRAY_TO_JSON(
      ARRAY_AGG(
        JSON_BUILD_OBJECT(
          'id', taxonomy.id,
          'level', taxonomy.level,
          'name', taxonomy.name,
          'parent', taxonomy.parent
        )
      )
    ) AS tags
FROM
    api.taxonomy taxonomy;

GRANT SELECT ON TABLE api.w_taxonomy TO web_anon;
