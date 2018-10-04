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
	-v ${PWD}/..:/tmp \
	-w /tmp \
	node
	@docker exec pgrunner apt-get update
	@docker exec pgrunner apt-get install -y postgresql jq

stop-pgrunner:
	@docker stop pgrunner
	@docker rm pgrunner

users:
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -f ./backend/postgres/users.sql

database: users
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -f ./backend/postgres/database.sql

functions: database
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/functions/row_inserted.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/functions/row_updated.sql

tables: functions
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.components.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.comments.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.taxonomy.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.scopes.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.statuses.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.usecases.sql

views:
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.components.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.comments.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.taxonomy.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.scopes.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.statuses.sql
	@docker exec pgrunner psql -h postgres -U ${PGPASSWORD} -d ${PGDATABASE} -f ./backend/postgres/tables/api.usecases.sql

schema: tables views

fixture:
	@docker exec pgrunner ./backend/postgres/json2sql.sh

all: tables fixture
