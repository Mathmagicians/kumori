PGPASSWORD="meritocracy"
PG_SCHEMA="meritocracy"
NETWORK="backend"
IMAGE="postgres"

setup: create_db create_access create_schema

create_db:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} \
	 -f databases.sql

create_access:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} \
	 -f access.sql

create_schema:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} -d ${PG_SCHEMA} \
	 -f schema.sql
