#!/usr/bin/env bash

RUN sed  -i "s/usename\s=\s'meritocracy'/usename = '${DB_CRUD_USER}'/" /docker-entrypoint-initdb.d/01.sql

./docker-entrypoint.sh
