-- DROP
DROP VIEW api.usecases;

-- VIEWS
CREATE VIEW api.usecases
AS
SELECT
    usecases.id AS id,
    name,
    description,
    created_at,
    updated_by,
    updated_at,
    ( SELECT COUNT(*) FROM public.usecase_revisions
      WHERE usecase_id = usecases.id
    ) AS revisions,
    ( CASE WHEN 0 <
      (
        SELECT COUNT(cous.usecase) FROM public.component_usecase AS cous
        WHERE cous.usecase = usecases.id
      ) THEN
      ( SELECT ARRAY_TO_JSON(
               ARRAY_AGG(
               JSON_BUILD_OBJECT(
                 'id', cous.component,
                 'name', comp.name))
               )
        FROM public.component_usecase AS cous
        LEFT JOIN public.components AS comp ON comp.id = cous.component
        WHERE cous.usecase = usecases.id
      ) ELSE
      ( JSON_BUILD_ARRAY()
      ) END) AS components,
      ( CASE WHEN 0 < (
            SELECT COUNT(usecase)
            FROM public.usecase_status
            WHERE usecase = usecases.id
      ) THEN
      ( SELECT JSON_BUILD_OBJECT('status', status.name, 'phase', phase.name)
        FROM public.usecase_status AS usecasest
        LEFT JOIN public.statuses AS status ON status.id = usecasest.status
        LEFT JOIN public.phases AS phase ON phase.id = status.phase
        WHERE usecasest.usecase = usecases.id
      ) ELSE
      ( SELECT JSON_BUILD_OBJECT('status', status.name, 'phase', phase.name)
        FROM public.statuses AS status
        LEFT JOIN public.phases AS phase ON phase.id = status.phase
        WHERE status.id = 1)
      END) AS status,
     ( CASE WHEN 0 <
      (
        SELECT COUNT(usecase) FROM public.usecase_taxonomy
        WHERE usecase = usecases.id
      ) THEN
      ( SELECT ARRAY_TO_JSON(
               ARRAY_AGG(
               JSON_BUILD_OBJECT(
                 'id', tax.id,
                 'name', tax.name))
               )
        FROM public.usecase_taxonomy
        LEFT JOIN public.taxonomy AS tax ON tax.id = usecase_taxonomy.taxonomy
        WHERE usecase_taxonomy.usecase = usecases.id
      ) ELSE
      ( JSON_BUILD_ARRAY()
      ) END) AS taxonomy
FROM
    public.usecases;

-- GRANTS
GRANT SELECT ON api.usecases TO web_anon;
GRANT ALL ON api.usecases TO editor;
