DROP FUNCTION IF EXISTS api.usecase_update (integer, TEXT, TEXT)
    CASCADE;

CREATE OR REPLACE FUNCTION api.usecase_update (id integer, name TEXT, description TEXT)
    RETURNS void
AS $$
DECLARE
    u_id ALIAS FOR id;
    u_name ALIAS FOR name;
    u_description ALIAS FOR description;
BEGIN
    UPDATE
        api.usecases AS u
    SET
        NAME = u_name,
        description = u_description
    WHERE
        u.id = u_id;
END
$$
LANGUAGE 'plpgsql';
