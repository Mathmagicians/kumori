FROM postgres:11-alpine

RUN apk add --no-cache curl jq

ENV DB_SCHEMA="api"
ENV DB_CRUD_USER="meritocracy"
ENV DB_CRUD_PASS="meritocracy"
ENV DB_R_USER="web_anon"
ENV TAXONOMY="https://raw.githubusercontent.com/Mathmagicians/kumori/master/meritocracy/frontend/src/api/mock/data/taxonomy.json"
ENV COMPONENTS="https://raw.githubusercontent.com/Mathmagicians/kumori/master/meritocracy/frontend/src/api/mock/data/techComponents.json"

COPY ./schema.sql /docker-entrypoint-initdb.d/01-schema.sql
COPY ./import.sh  /docker-entrypoint-initdb.d/02-data.sh
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod -R 777 /docker-entrypoint-initdb.d
RUN sed -i "4i /entrypoint.sh" /usr/local/bin/docker-entrypoint.sh
