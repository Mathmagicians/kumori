FROM postgres:11-alpine

COPY ./schema.sql /docker-entrypoint-initdb.d/01-schema.sql
COPY ./fixture.sql /docker-entrypoint-initdb.d/02-fixture.sql
