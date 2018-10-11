#!/usr/bin/env bash

# Replace CRUD user
sed  -i "s/meritocracy/${DB_CRUD_USER}/g" /docker-entrypoint-initdb.d/schema.sql

# Replace CRUD password
sed  -i "s/PASSWORD\s'${DB_CRUD_USER}'/PASSWORD '${DB_CRUD_PASS}'/" /docker-entrypoint-initdb.d/schema.sql

# Replace READ user
sed  -i "s/web_anon/${DB_R_USER}/g" /docker-entrypoint-initdb.d/schema.sql

# Replace Schema
sed  -i "s/api/${DB_SCHEMA}/g" /docker-entrypoint-initdb.d/schema.sql
