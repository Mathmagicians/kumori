POSTGRES_PASSWORD = $(shell cat .env | grep 'POSTGRES_PASSWORD' | awk -F "=" '{print $$2}')
POSTGRES_USERNAME = $(shell cat .env | grep 'POSTGRES_USERNAME' | awk -F "=" '{print $$2}')
POSTGRES_DATABASE = $(shell cat .env | grep 'POSTGRES_DATABASE' | awk -F "=" '{print $$2}')
PGRST_JWT_KEY = $(shell cat .env | grep 'PGRST_JWT_KEY' | awk -F "=" '{print $$2}')
ENV=dev
BUILD_IMAGE=mathmagicians/kumori_build:latest
.PHONY: build push sonar-scan

build:
	@cd services/frontend && make -f Makefile install build && cd ../../

up:
	@docker-compose -f kumori.${ENV}.yml up -d --build

down:
	@docker-compose -f kumori.${ENV}.yml down

cli:
	@cd services/frontend && make -f Makefile build_image && cd ../../
	@docker run --rm -it -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE}

flyway:
	@docker run --rm --net=kumori_kumori -v $(shell pwd)/services/flyway/sql:/flyway/sql boxfuse/flyway:latest -url=jdbc:postgresql://postgres/ -user="${POSTGRES_USERNAME}" -password="${POSTGRES_PASSWORD}" -connectRetries=60 -placeholders.dbrole=${POSTGRES_USERNAME} info

fixture:
	@docker stop kumori_postgrest
	docker cp services/fixture/. kumori_postgres:/tmp
	@docker exec -u postgres -w /tmp kumori_postgres psql -U "${POSTGRES_PASSWORD}" "${POSTGRES_DATABASE}" -f ./components.sql
	@docker start kumori_postgrest

dump:
	@docker stop kumori_postgrest
	@docker exec -u postgres kumori_postgres pg_dump --data-only -U "${POSTGRES_PASSWORD}" "${POSTGRES_DATABASE}" > dump.pgsql
	@docker start kumori_postgrest

test: unit-test integration-test

unit-test:
	@cd services/frontend && make -f Makefile test && cd ../../

integration-test:
	@./ready.sh
	@docker run --rm -v $(shell pwd)/services/jmeter:/jmeter --entrypoint /bin/rm localgod/jmeter -rf /jmeter/report /jmeter/output.jtl
	@docker run --rm -v $(shell pwd)/services/jmeter:/jmeter \
	--network=kumori_kumori localgod/jmeter -n -t /jmeter/kumori.jmx -l /jmeter/output.jtl -e -o /jmeter/report -Joutputpath=/jmeter -Jhost=devserver -Jjwt=${KUMORI_JWT}

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
