CREATE OR REPLACE FUNCTION api.search_component (pattern VARCHAR)
    RETURNS TABLE (id INT, name TEXT)
AS $$
DECLARE
    var_r record;
BEGIN
    FOR var_r IN (
        SELECT
            comp_search.id,
            comp_search.name
        FROM (
            SELECT
                comp.id AS id,
                comp.name AS name,
                SETWEIGHT(TO_TSVECTOR('english', comp.name), 'A')
                || ' ' ||
                SETWEIGHT(TO_TSVECTOR('english', comp.description), 'B')
                || ' ' || SETWEIGHT(TO_TSVECTOR('english', COALESCE((STRING_AGG(comm.comment, ' ')), '')),
                    'C')
                || ' ' ||
                SETWEIGHT(TO_TSVECTOR('english', COALESCE((STRING_AGG(usec.name, ' ')), '')),
                    'C')
                || ' ' || SETWEIGHT(TO_TSVECTOR('english', COALESCE((STRING_AGG(usec.description, ' ')), '')),
                    'C') AS document
            FROM
                api.components AS comp
            LEFT JOIN api.comments AS comm ON comp.id = comm.component
            LEFT JOIN api.usecases AS usec ON comp.id = usec.component
            GROUP BY comp.id
        ) AS comp_search
WHERE
    comp_search.document @@ TO_TSQUERY('english', pattern)
ORDER BY
    TS_RANK(comp_search.document, TO_TSQUERY('english', pattern))
    DESC)
LOOP
    id := var_r.id;
    name := var_r.name;
    RETURN NEXT;
END LOOP;
END;
$$
LANGUAGE 'plpgsql';
