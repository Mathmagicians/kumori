#!/usr/bin/env bash

find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/meritocracy/${DB_CRUD_USER}/g"
find . -type f -name "*.sql" -print0 | xargs -0 sed -i "s/meritocracy/${DB_R_USER}/g"

sed  -i "s/PASSWORD\s'${DB_CRUD_USER}'/PASSWORD '${DB_CRUD_PASS}/" /docker-entrypoint-initdb.d/01.sql

./docker-entrypoint.sh
