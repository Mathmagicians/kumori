CREATE OR REPLACE VIEW api.w_usecases
AS
SELECT
    usec.id,
    usec.name,
    usec.description,
    (
      CASE WHEN sta.id > 1
      THEN ( SELECT name
             FROM api.statuses
             WHERE id = sta.id)
      ELSE ( SELECT name FROM api.statuses WHERE id = 1)
      END
    ) AS status,
    (
      CASE WHEN 0 < ( SELECT COUNT(cous.usecase)
                      FROM api.component_usecase AS cous
                      WHERE cous.usecase = usec.id)
      THEN ( SELECT ARRAY_TO_JSON(ARRAY_AGG(JSON_BUILD_OBJECT('id', cous.component, 'name', comp.NAME))) AS components
                FROM api.component_usecase AS cous
                LEFT JOIN api.components AS comp ON comp.id = cous.component
                WHERE cous.usecase = usec.id)
      ELSE (JSON_BUILD_ARRAY())
      END
    ) AS components
FROM
    api.usecases AS usec
    LEFT JOIN api.component_usecase AS co_us ON co_us.usecase = usec.id
    LEFT JOIN api.components AS co ON co.id = co_us.component
    LEFT JOIN api.statuses AS sta ON sta.id = co_us.status
GROUP BY
    usec.id,
    co_us.status,
    co.id,
    sta.name,
    sta.id;

GRANT SELECT ON TABLE api.w_usecases TO web_anon;
GRANT SELECT ON TABLE api.w_usecases TO editor;

CREATE OR REPLACE VIEW api.w_simple_components
AS
SELECT
    DISTINCT ON (c.id) c.id,
    c.name,
    c.description,
    tax.id AS tag,
    st.id AS status,
    (   SELECT
            JSON_BUILD_OBJECT('id', cu.status, 'name', s.name, 'phase', s.phase)
        FROM
            api.component_usecase AS cu
        LEFT JOIN api.statuses AS s ON cu.status = s.id
        WHERE cu.usecase = c.primary_usecase
    ) AS primary_usecase,
    c.name || ' ' || c.description as search
FROM
    api.components AS c
    LEFT JOIN api.component_usecase AS uscom ON c.id = uscom.component
    LEFT JOIN api.usecases AS usc ON uscom.usecase = usc.id
    LEFT JOIN api.statuses AS st ON uscom.status = st.id
    LEFT JOIN api.usecase_taxonomy AS usetax ON usetax.usecase = usc.id
    LEFT JOIN api.taxonomy AS tax ON tax.id = usetax.taxonomy;

GRANT SELECT ON TABLE api.w_simple_components TO web_anon;

GRANT SELECT ON TABLE api.w_simple_components TO editor;

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
            WHERE parent = tax.id) IS NULL
          THEN (JSON_BUILD_ARRAY())
          ELSE (
            SELECT
            ARRAY_TO_JSON(ARRAY_AGG(api.taxonomy.name))
            FROM
            api.taxonomy
            WHERE
            parent = tax.id)
          END) AS children
FROM
    api.taxonomy AS tax;

GRANT SELECT ON TABLE api.w_burst TO web_anon;

GRANT SELECT ON TABLE api.w_burst TO editor;

CREATE OR REPLACE VIEW api.w_components
AS
SELECT
    component.id AS uid,
    component.name as name,
    (
      CASE WHEN 0 < (
        SELECT COUNT(st.name) FROM api.components AS comp
        LEFT JOIN api.component_usecase AS cmus ON comp.primary_usecase = cmus.usecase
        LEFT JOIN api.statuses AS st ON cmus.status = st.id
        WHERE comp.id = component.id)
      THEN (
        SELECT st.name FROM api.components AS comp
        LEFT JOIN api.component_usecase AS cmus ON comp.primary_usecase = cmus.usecase
                LEFT JOIN api.statuses AS st ON cmus.status = st.id
        WHERE comp.id = component.id)
      ELSE (SELECT name FROM api.statuses WHERE id = 1) END
    ) AS status,
    component.description,
	(
    CASE WHEN 0 < (SELECT COUNT(co.id) FROM api.comments AS co WHERE co.component = component.id)
    THEN (SELECT array_to_json(array_agg(co.comment))
            FROM api.comments AS co
            WHERE co.component = component.id)
    ELSE (json_build_array()) END
	) AS comments,
  (
    CASE WHEN 0 < (
      SELECT COUNT(st.name) FROM api.components AS comp
      LEFT JOIN api.component_usecase AS cmus ON comp.primary_usecase = cmus.usecase
      LEFT JOIN api.statuses AS st ON cmus.status = st.id
      WHERE comp.id = component.id)
    THEN (
      SELECT array_to_json(array_agg(tax.name)) FROM api.components AS comp
      LEFT JOIN api.usecases AS us ON comp.primary_usecase = us.id
      LEFT JOIN api.usecase_taxonomy AS ustax ON us.id = ustax.usecase
      LEFT JOIN api.taxonomy AS tax ON ustax.taxonomy = tax.id
      WHERE comp.id = component.id)
    ELSE (json_build_array()) END
  ) AS tags,
    json_build_array() AS licenses,
	(
	 CASE WHEN 0 < (SELECT COUNT(co.id) FROM api.links AS co WHERE co.component = component.id)
	 THEN (SELECT array_to_json(array_agg(json_build_object(
        'type',co.type,
        'ref',co.ref)))
      FROM api.links AS co
      WHERE co.component = component.id)
	 ELSE (json_build_array()) END
	) AS links,
  (
    CASE WHEN 0 < (
      SELECT COUNT(us.id)
      FROM api.usecases AS us
      LEFT JOIN api.component_usecase AS uscom ON us.id = uscom.usecase
      WHERE uscom.component = component.id)
    THEN (
      SELECT array_to_json(array_agg(json_build_object(
        'name',us.name,
        'description',us.description,
        'status',st.name
      )))
      FROM api.usecases AS us
      LEFT JOIN api.component_usecase AS uscom ON us.id = uscom.usecase
      LEFT JOIN api.statuses AS st ON uscom.status = st.id
      WHERE uscom.component = component.id)
      ELSE (json_build_array()) END
  ) AS usecases
FROM
    api.components AS component;

GRANT SELECT ON TABLE api.w_components TO web_anon;
GRANT SELECT ON TABLE api.w_components TO editor;


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
GRANT SELECT ON TABLE api.w_taxonomy TO editor;
