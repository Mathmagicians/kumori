DROP VIEW IF EXISTS api.w_components;

CREATE OR REPLACE VIEW api.w_components
AS
SELECT
    component.id AS uid,
    component.name as name,
    status.name as status,
    component.description,
	(
	 CASE WHEN 0 < (SELECT COUNT(co.id) FROM api.comments AS co WHERE co.component = component.id)
	 THEN (SELECT array_to_json(array_agg(co.comment))
            FROM api.comments AS co
            WHERE co.component = component.id)
	 ELSE (json_build_array()) END
	) AS comments,
	(
	 CASE WHEN 0 < (SELECT COUNT(usec.component)
                  FROM api.usecase_taxonomy AS usetax
                  LEFT JOIN api.usecases AS usec ON usetax.usecase = usec.id LEFT JOIN api.taxonomy AS tax ON usetax.taxonomy = tax.id WHERE usec.component = component.id)
	 THEN (SELECT array_to_json(array_agg(tax.name))
         FROM api.usecase_taxonomy AS usetax
         LEFT JOIN api.usecases AS usec ON usetax.usecase = usec.id
         LEFT JOIN api.taxonomy AS tax ON usetax.taxonomy = tax.id
         WHERE usec.component = component.id
         AND usetax.usecase = (SELECT MIN(usetax.usecase)
         FROM api.usecase_taxonomy AS usetax
         LEFT JOIN api.usecases AS usec ON usetax.usecase = usec.id
         LEFT JOIN api.taxonomy AS tax ON usetax.taxonomy = tax.id WHERE usec.component = component.id))
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
      SELECT array_to_json(array_agg(json_build_object(
        'name',us.name,
        'description',us.description,
        'status',status.name,
        'scope',sco.name)))
      FROM api.usecases AS us
          JOIN api.statuses status ON us.status = status.id
          JOIN api.scopes sco ON us.scope = sco.id
      WHERE us.component = component.id
    ) AS usecases
FROM
    api.components AS component
JOIN api.statuses status ON component.status = status.id;


GRANT SELECT ON TABLE api.w_components TO web_anon;
GRANT SELECT ON TABLE api.w_components TO editor;
