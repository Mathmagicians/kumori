GRANT SELECT ON public.taxonomy TO web_anon;
GRANT SELECT ON public.taxonomy TO editor;

GRANT SELECT ON public.phases TO web_anon;
GRANT SELECT ON public.phases TO editor;

GRANT SELECT ON public.statuses TO web_anon;
GRANT SELECT ON public.statuses TO editor;

GRANT SELECT ON public.components TO web_anon;
GRANT ALL ON public.components to editor;

GRANT SELECT ON public.comments TO web_anon;
GRANT ALL ON public.comments to editor;

GRANT SELECT ON public.links TO web_anon;
GRANT ALL ON public.links to editor;

GRANT SELECT ON public.usecases TO web_anon;
GRANT ALL ON public.usecases to editor;

GRANT SELECT ON public.usecase_taxonomy TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.usecase_taxonomy to editor;

GRANT SELECT ON public.component_usecase TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.component_usecase to editor;

--

GRANT SELECT ON api.taxonomy TO web_anon;
GRANT SELECT ON api.taxonomy TO editor;

GRANT SELECT ON api.phases TO web_anon;
GRANT SELECT ON api.phases TO editor;

GRANT SELECT ON api.statuses TO web_anon;
GRANT SELECT ON api.statuses TO editor;

GRANT SELECT ON api.components TO web_anon;
GRANT ALL ON api.components to editor;

GRANT SELECT ON api.comments TO web_anon;
GRANT ALL ON api.comments to editor;

GRANT SELECT ON api.links TO web_anon;
GRANT ALL ON api.links to editor;

GRANT SELECT ON api.usecases TO web_anon;
GRANT ALL ON api.usecases to editor;

GRANT SELECT ON api.usecase_taxonomy TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.usecase_taxonomy to editor;

GRANT SELECT ON api.component_usecase TO web_anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.component_usecase to editor;
