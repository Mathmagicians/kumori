PGPASSWORD="meritocracy"
PG_SCHEMA="meritocracy"
NETWORK="backend"
IMAGE="postgres:9.4"

setup: create_databases access_databases create_schema

create_databases:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} \
	 -f databases.sql

access_databases:
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
