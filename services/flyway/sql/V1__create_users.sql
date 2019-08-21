CREATE ROLE web_anon NOLOGIN;

COMMENT ON ROLE web_anon IS 'This is the default anonymous user for read only access.';

CREATE ROLE editor NOLOGIN;

COMMENT ON ROLE editor IS 'This is a editor user with CRUD.';

GRANT web_anon TO ${dbrole};

GRANT editor TO ${dbrole};
