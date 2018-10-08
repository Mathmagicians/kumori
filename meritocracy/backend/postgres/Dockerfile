FROM postgres:11-alpine

RUN apk add --no-cache curl jq

ENV DB_NAME=""
ENV DB_SCHEMA=""
ENV DB_CRUD_USER=""
ENV DB_CRUD_PASS=""
ENV DB_R_USER=""
ENV DB_R_PASS=""

COPY ./users.sql                         /docker-entrypoint-initdb.d/01.sql
COPY ./database.sql                      /docker-entrypoint-initdb.d/02.sql
COPY ./functions/row_inserted.sql        /docker-entrypoint-initdb.d/03.sql
COPY ./functions/row_updated.sql         /docker-entrypoint-initdb.d/04.sql
COPY ./tables/api.taxonomy.sql           /docker-entrypoint-initdb.d/05.sql
COPY ./tables/api.statuses.sql           /docker-entrypoint-initdb.d/06.sql
COPY ./tables/api.scopes.sql             /docker-entrypoint-initdb.d/07.sql
COPY ./tables/api.components.sql         /docker-entrypoint-initdb.d/08.sql
COPY ./tables/api.comments.sql           /docker-entrypoint-initdb.d/09.sql
COPY ./tables/api.links.sql              /docker-entrypoint-initdb.d/10.sql
COPY ./tables/api.usecases.sql           /docker-entrypoint-initdb.d/11.sql
COPY ./tables/api.component_taxonomy.sql /docker-entrypoint-initdb.d/12.sql
COPY ./views/api.w_usecases.sql          /docker-entrypoint-initdb.d/13.sql
COPY ./views/api.w_components.sql        /docker-entrypoint-initdb.d/14.sql
COPY ./views/api.w_taxonomy.sql          /docker-entrypoint-initdb.d/15.sql

ENTRYPOINT ["entrypoint.sh"]
