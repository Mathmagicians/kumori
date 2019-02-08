DROP FUNCTION IF EXISTS api.usecase_update (integer, TEXT, TEXT, integer)
    CASCADE;

CREATE OR REPLACE FUNCTION api.usecase_update (id integer, name TEXT, description TEXT, scope integer)
    RETURNS void
AS $$
DECLARE
    u_id ALIAS FOR id;
    u_name ALIAS FOR name;
    u_description ALIAS FOR description;
    u_scope ALIAS FOR scope;
BEGIN
    UPDATE
        api.usecases AS u
    SET
        NAME = u_name,
        description = u_description,
        scope = u_scope
    WHERE
        u.id = u_id;
END
$$
LANGUAGE 'plpgsql';
