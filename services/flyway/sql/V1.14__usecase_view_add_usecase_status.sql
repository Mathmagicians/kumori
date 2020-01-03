-- DROP
DROP TABLE public.usecase_status;
DROP VIEW api.usecases;

-- VIEWS
CREATE OR REPLACE VIEW api.usecases AS
SELECT usecases.id,
   usecases.name,
   usecases.description,
   usecases.created_at,
   usecases.updated_by,
   usecases.updated_at,
   ( SELECT count(*) AS count
          FROM usecase_revisions
         WHERE usecase_revisions.usecase_id = usecases.id) AS revisions,
       CASE
           WHEN 0 < (( SELECT count(cous.usecase) AS count
              FROM component_usecase cous
              WHERE cous.usecase = usecases.id))
           THEN ( SELECT array_to_json(array_agg(json_build_object(
             'id', cous.component,
             'name', comp.name,
             'description', cous.description,
             'status', st.name,
             'phase', ph.name))) AS array_to_json
              FROM component_usecase cous
              LEFT JOIN components comp ON comp.id = cous.component
              LEFT JOIN public.statuses st ON cous.status = st.id
              LEFT JOIN public.phases ph ON st.phase = ph.id
              WHERE cous.usecase = usecases.id)
           ELSE json_build_array()
       END AS components,
       CASE
           WHEN 0 < (( SELECT count(usecase_taxonomy.usecase) AS count
              FROM usecase_taxonomy
             WHERE usecase_taxonomy.usecase = usecases.id)) THEN ( SELECT array_to_json(array_agg(json_build_object('id', tax.id, 'name', tax.name))) AS array_to_json
              FROM usecase_taxonomy
                LEFT JOIN taxonomy tax ON tax.id = usecase_taxonomy.taxonomy
             WHERE usecase_taxonomy.usecase = usecases.id)
           ELSE json_build_array()
       END AS taxonomy
  FROM usecases;

-- GRANTS

GRANT SELECT ON TABLE api.usecases TO web_anon;
GRANT ALL ON TABLE api.usecases TO meritocracy;
GRANT ALL ON TABLE api.usecases TO editor;
