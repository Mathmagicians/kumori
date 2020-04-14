POSTGRES_PASSWORD = $(shell cat .env | grep 'POSTGRES_PASSWORD' | awk -F "=" '{print $$2}')
POSTGREST_CONNECTION_DB = $(shell cat .env | grep 'POSTGREST_CONNECTION_DB' | awk -F "=" '{print $$2}')
PGRST_JWT_KEY = $(shell cat .env | grep 'PGRST_JWT_KEY' | awk -F "=" '{print $$2}')
ENV=dev
BUILD_IMAGE=mathmagicians/kumori_build:latest
.PHONY: build push sonar-scan

build:
	@cd services/frontend && make -f Makefile install build && cd ../../

up:
	@docker-compose -f kumori.${ENV}.yml up -d

down:
	@docker-compose -f kumori.${ENV}.yml down

flyway:
	@docker run --rm --net=kumori_kumori -v $(shell pwd)/services/flyway/sql:/flyway/sql boxfuse/flyway:latest -url=jdbc:postgresql://postgres/ -user=postgres -password=postgres -connectRetries=60 info

jmeter:
	@docker run --rm -v $(shell pwd)/services/jmeter:/jmeter --entrypoint /bin/rm localgod/jmeter -rf /jmeter/report /jmeter/output.jtl
	@docker run --rm -v $(shell pwd)/services/jmeter:/jmeter \
	--network=kumori_kumori localgod/jmeter -n -t /jmeter/kumori.jmx -l /jmeter/output.jtl -e -o /jmeter/report -Joutputpath=/jmeter -Jhost=devserver -Jjwt=${KUMORI_JWT}

dump:
	@docker stop kumori-postgrest
	@docker exec -u postgres kumori-postgres pg_dump --data-only -U "${POSTGRES_PASSWORD}" "${POSTGREST_CONNECTION_DB}" > dump.pgsql
	@docker start kumori-postgrest

test: unit-test integration-test

unit-test:
	@docker run --rm -v ${PWD}/services/frontend:/tmp -w /tmp ${BUILD_IMAGE} npm run test:unit

integration-test:
	@./ready.sh

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
