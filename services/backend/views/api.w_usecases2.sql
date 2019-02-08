DROP VIEW IF EXISTS api.w_usecases2;

CREATE OR REPLACE VIEW api.w_usecases2
AS
SELECT
    usec.id,
    usec.NAME,
    usec.description,
    sco.NAME AS scope,
    sta.NAME AS status,
    ( CASE WHEN 0 < (
        SELECT COUNT(cous.usecase)
        FROM api.component_usecase AS cous
        WHERE cous.usecase = usec.id)
      THEN (
        SELECT ARRAY_TO_JSON(
          ARRAY_AGG(
            JSON_BUILD_OBJECT(
              'id', cous.component,
              'name', comp.NAME)
            )
          ) AS components
          FROM api.component_usecase AS cous
          LEFT JOIN api.components AS comp ON comp.id = cous.component
        WHERE cous.usecase = usec.id
      )
      ELSE
        (JSON_BUILD_ARRAY())
      END
    ) AS components
FROM
    api.usecases AS usec
    JOIN api.component_usecase AS co_us ON co_us.usecase = usec.id
    JOIN api.components AS co ON co.id = co_us.component
    JOIN api.statuses AS sta ON sta.id = co_us.status
    JOIN api.scopes AS sco ON sco.id = usec.scope
GROUP BY
    usec.id,
    co_us.status,
    co.id,
    sco.NAME,
    sta.NAME;

GRANT SELECT ON TABLE api.w_usecases2 TO web_anon;
GRANT SELECT ON TABLE api.w_usecases2 TO editor;