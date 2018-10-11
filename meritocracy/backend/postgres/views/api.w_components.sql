DROP VIEW IF EXISTS api.w_components;

CREATE OR REPLACE VIEW api.w_components
AS
SELECT
    MD5(COALESCE(component.name, '') || COALESCE(component.description, '')) AS uid,
    component.name as name,
    status.name as status,
    component.description,
    (
        SELECT array_to_json(array_agg(co.comment))
        FROM api.comments AS co
        WHERE co.component = component.id
    ) as comments,
    (
        SELECT array_to_json(array_agg(tx.name))
        FROM api.component_taxonomy AS ct
        JOIN api.taxonomy AS tx ON ct.taxonomy = tx.id
        WHERE ct.component = component.id
    ) as tags,
    json_build_array() AS licenses,
    (
      SELECT array_to_json(array_agg(json_build_object(
        'type',co.type,
        'ref',co.ref)))
      FROM api.links AS co
      WHERE co.component = component.id
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
    api.components component
JOIN api.statuses status ON component.status = status.id;

GRANT SELECT ON TABLE api.w_components TO web_anon;
