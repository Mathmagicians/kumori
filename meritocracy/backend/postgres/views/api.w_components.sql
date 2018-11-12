DROP VIEW IF EXISTS api.w_components;

CREATE OR REPLACE VIEW api.w_components
AS
SELECT
    component.id AS uid,
    component.name as name,
    (
      CASE WHEN 0 < (
        SELECT COUNT(st.name) FROM api.components AS comp
        LEFT JOIN api.usecases AS us ON comp.primary_usecase = us.id
        LEFT JOIN api.statuses AS st ON us.status = st.id
        WHERE comp.id = component.id)
      THEN (
        SELECT st.name FROM api.components AS comp
        LEFT JOIN api.usecases AS us ON comp.primary_usecase = us.id
        LEFT JOIN api.statuses AS st ON us.status = st.id
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
      LEFT JOIN api.usecases AS us ON comp.primary_usecase = us.id
      LEFT JOIN api.statuses AS st ON us.status = st.id
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
        'status',st.name,
        'scope',sco.name
      )))
      FROM api.usecases AS us
      LEFT JOIN api.component_usecase AS uscom ON us.id = uscom.usecase
      LEFT JOIN api.scopes AS sco ON us.scope = sco.id
      LEFT JOIN api.statuses AS st ON us.status = st.id
      WHERE uscom.component = component.id)
      ELSE (json_build_array()) END
  ) AS usecases
FROM
    api.components AS component;

GRANT SELECT ON TABLE api.w_components TO web_anon;
GRANT SELECT ON TABLE api.w_components TO editor;
