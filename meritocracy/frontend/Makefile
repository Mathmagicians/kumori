.PHONY: setup build unit e2e test serve-start serve-logs serve-stop shell

autofix:
	 find ./src -iname "*.js" -type f -exec echo {} \;

setup:
	@docker run --rm -dt --name setup -v ${PWD}:/tmp -w /tmp node
	@docker exec setup npm install
	@docker rm -f setup

build:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run build

unit:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run unit

e2e:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run e2e

lint:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run lint

test: unit e2e

shell:
	@docker run --rm -it -v ${PWD}:/tmp -w /tmp -p 8050:8080 node bash

####### BACKEND ######

PGPASSWORD="postgres"
NETWORK="backend"
IMAGE="postgres"

schema:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} \
	 -f postgres/schema.sql

fixture:
	@docker run --rm -it -v ${PWD}:/tmp -w /tmp -p 8050:8080 node ./postgres/json2sql.sh

load:
	@docker run -it \
	 --network=${NETWORK} \
	 --rm \
	 -e "PGPASSWORD=${PGPASSWORD}" \
	 -v $(shell pwd):/tmp \
	 -w /tmp ${IMAGE} psql -h postgres -U ${PGPASSWORD} \
	 -f postgres/fixture.sql
