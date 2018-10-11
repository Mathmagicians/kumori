FROM postgres:11-alpine

RUN apk add --no-cache curl jq

ENV DB_SCHEMA="api"
ENV DB_CRUD_USER="meritocracy"
ENV DB_CRUD_PASS="meritocracy"
ENV DB_R_USER="web_anon"

COPY ./schema.sql /docker-entrypoint-initdb.d/schema.sql
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod -R 777 /docker-entrypoint-initdb.d
RUN sed -i "4i /entrypoint.sh" /usr/local/bin/docker-entrypoint.sh
