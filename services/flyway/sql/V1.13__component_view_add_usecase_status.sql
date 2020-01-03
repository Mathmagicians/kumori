-- DROP
DROP VIEW api.components;

-- VIEWS
CREATE OR REPLACE VIEW api.components AS
SELECT components.id,
   components.name,
   components.description,
   components.primary_usecase,
   components.created_at,
   components.updated_by,
   components.updated_at,
   ( SELECT count(*) AS count
     FROM public.components_revisions
     WHERE components_revisions.component_id = components.id) AS revisions,
   (components.name || ' '::text) || components.description AS search,
   CASE
       WHEN 0 < (( SELECT count(uc.id) AS count
                   FROM usecases uc
                   LEFT JOIN public.component_usecase cu ON uc.id = cu.usecase
                   WHERE cu.component = components.id))
      THEN ( SELECT array_to_json(
                    array_agg(
                    json_build_object(
                      'id', uc.id,
                      'name', uc.name,
                      'description', uc.description,
                      'status', st.name,
                      'phase', ph.name))) AS array_to_json
             FROM usecases uc
             LEFT JOIN public.component_usecase cu ON uc.id = cu.usecase
             LEFT JOIN public.statuses st ON cu.status = st.id
             LEFT JOIN public.phases ph ON st.phase = ph.id
             WHERE cu.component = components.id)
       ELSE json_build_array()
   END AS usecases
  FROM components;

-- GRANTS
GRANT SELECT ON TABLE api.components TO web_anon;
GRANT ALL ON TABLE api.components TO meritocracy;
GRANT ALL ON TABLE api.components TO editor;
