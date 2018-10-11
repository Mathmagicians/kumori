# Meritocracy Postgres Server

## Environment configuration options

All options have default values.

* DB_SCHEMA (Database schema)
* DB_CRUD_USER (Database read/write user)
* DB_CRUD_PASS (Database read/write user password)
* DB_R_USER (Database read only user)
* TAXONOMY (Url to JSON formatted list of taxonomy to import)
* COMPONENTS (Url to JSON formatted list of components to import)

## Run

    $ docker run --rm --name meritocracy_db_run -it mathmagicians/meritocracy_db:latest
