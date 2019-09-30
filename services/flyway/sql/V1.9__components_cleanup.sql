DROP VIEW api.w_components;
DROP VIEW api.w_simple_components;

CREATE OR REPLACE VIEW api.components AS
SELECT
  components.id,
  components.name,
  components.description,
  components.primary_usecase,
  components.created_at,
  components.updated_by,
  components.updated_at,
  (
    SELECT
      COUNT(*) AS COUNT
    FROM
      components_revisions
    WHERE
      components_revisions.component_id = components.id
  ) AS revisions,
  (
    components.name || ' '::TEXT || components.description
  ) AS search,
    (
    CASE WHEN 0 < ((
      SELECT
        COUNT(uc.id) AS COUNT
      FROM
        public.usecases AS uc
      LEFT JOIN public.component_usecase AS cu ON uc.id = cu.usecase
      WHERE
        cu.component = components.id
    ))
    THEN (
      SELECT
          ARRAY_TO_JSON(
            ARRAY_AGG(
              JSON_BUILD_OBJECT(
                'id', uc.id,
                'name', uc.name,
                'description', uc.description
              )
            )
          )
      FROM
        public.usecases AS uc
      LEFT JOIN component_usecase AS cu ON uc.id = cu.usecase
      WHERE
        cu.component = components.id
    )
    ELSE (
      JSON_BUILD_ARRAY()
    )
    END
  ) AS usecases
  FROM
      components;
