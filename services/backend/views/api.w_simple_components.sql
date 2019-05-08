DROP VIEW IF EXISTS api.w_simple_components;

CREATE OR REPLACE VIEW api.w_simple_components
AS
SELECT
    DISTINCT ON (c.id) c.id,
    c.name,
    c.description,
    tax.id AS tag,
    st.id AS status,
    (   SELECT
            JSON_BUILD_OBJECT('id', cu.status, 'name', s.NAME, 'phase', s.phase)
        FROM
            api.component_usecase AS cu
        LEFT JOIN api.statuses AS s ON cu.status = s.id
        WHERE cu.usecase = c.primary_usecase
    ) AS primary_usecase,
    SETWEIGHT(TO_TSVECTOR('simple', c.name), 'A')
    || ' ' ||
    SETWEIGHT(TO_TSVECTOR('simple', c.description), 'B') AS fts
FROM
    api.components AS c
    LEFT JOIN api.component_usecase AS uscom ON c.id = uscom.component
    LEFT JOIN api.usecases AS usc ON uscom.usecase = usc.id
    LEFT JOIN api.statuses AS st ON uscom.status = st.id
    LEFT JOIN api.usecase_taxonomy AS usetax ON usetax.usecase = usc.id
    LEFT JOIN api.taxonomy AS tax ON tax.id = usetax.taxonomy;

GRANT SELECT ON TABLE api.w_simple_components TO web_anon;

GRANT SELECT ON TABLE api.w_simple_components TO editor;
