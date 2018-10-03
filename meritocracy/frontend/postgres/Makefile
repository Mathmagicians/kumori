PGDATABASE='meritocracy'
PG_HOST='postgres'
PGPASSWORD="postgres"
NETWORK="backend"
IMAGE="postgres"

.PHONY: start-pgrunner stop-pgrunner users tables functions triggers schema fixture

start-pgrunner:
	@docker run \
	-e "PGPASSWORD=${PGPASSWORD}" \
	-dt \
	--network=${NETWORK} \
	--name pgrunner \
	-v ${PWD}:/tmp \
	-w /tmp \
	node
	@docker exec pgrunner yum install -y postgresql jq

stop-pgrunner:
	@docker stop pgrunner
	@docker rm pgrunner

users:
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -f users.sql

database: users
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -f database.sql

functions: database
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f functions/row_inserted.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f functions/row_updated.sql

tables: functions
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.components.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.comments.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.taxonomy.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.scopes.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.statuses.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f tables/api.usecases.sql

schema: tables

fixture:
	@docker exec pgrunner ./json2sql.sh
