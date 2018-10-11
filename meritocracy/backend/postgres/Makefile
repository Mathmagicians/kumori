PGDATABASE='meritocracy'
PG_HOST='postgres'
PGPASSWORD="postgres"
NETWORK="backend"
IMAGE="postgres"

.PHONY: start-pgrunner stop-pgrunner fixture

start-pgrunner:
	@docker run \
	-e "PGPASSWORD=${PGPASSWORD}" \
	-dt \
	--network=${NETWORK} \
	--name pgrunner \
	-v ${PWD}/../..:/tmp \
	-w /tmp \
	node
	@docker exec pgrunner apt-get update
	@docker exec pgrunner apt-get install -y postgresql jq

stop-pgrunner:
	@docker stop pgrunner
	@docker rm pgrunner

fixture:
	@docker exec pgrunner ./backend/postgres/json2sql.sh

all: fixture
