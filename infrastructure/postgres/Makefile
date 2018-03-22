setup: create_databases access_databases create_schema_calculated create_schema_raw

create_databases:
	@docker run -it \
	 --network=kumori_backend \
	 --rm \
	 -e "PGPASSWORD=postgres" \
	 -v $(shell pwd):/tmp \
	 -w /tmp postgres:alpine psql -h postgres -U postgres \
	 -f databases.sql

access_databases:
	@docker run -it \
	 --network=kumori_backend \
	 --rm \
	 -e "PGPASSWORD=postgres" \
	 -v $(shell pwd):/tmp \
	 -w /tmp postgres:alpine psql -h postgres -U postgres \
	 -f access.sql

create_schema_calculated:
	@docker run -it \
	 --network=kumori_backend \
	 --rm \
	 -e "PGPASSWORD=postgres" \
	 -v $(shell pwd):/tmp \
	 -w /tmp postgres:alpine psql -h postgres -U postgres -d calculated \
	 -f schema_calculated.sql

create_schema_raw:
	@docker run -it \
	 --network=kumori_backend \
	 --rm \
	 -e "PGPASSWORD=postgres" \
	 -v $(shell pwd):/tmp \
	 -w /tmp postgres:alpine psql -h postgres -U postgres -d raw \
	 -f schema_raw.sql
