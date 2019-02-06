POSTGRES_PASSWORD = $(shell cat .env | grep 'POSTGRES_PASSWORD' | awk -F "=" '{print $$2}')
POSTGREST_CONNECTION_DB = $(shell cat .env | grep 'POSTGREST_CONNECTION_DB' | awk -F "=" '{print $$2}')
BUILD_IMAGE=mathmagicians/kumori_build:latest
.PHONY: build push sonar-scan

build:
	@cd services/backend && make -f Makefile build && cd ../../
	@cd services/frontend && make -f Makefile install build && cd ../../

start:
	@docker-compose -f kumori.yml up -d

stop:
	@docker-compose -f kumori.yml down

fixture:
	@./ready.sh
	@docker stop kumori-postgrest
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} curl -s -o dump.pgsql https://raw.githubusercontent.com/Mathmagicians/kumori/fixture/dump.pgsql
	@docker exec -i -u postgres kumori-postgres psql -U "${POSTGRES_PASSWORD}" "${POSTGREST_CONNECTION_DB}" < dump.pgsql
	@docker exec -i -u postgres kumori-postgres rm -rf dump.pgsql
	@docker start kumori-postgrest

dump:
	@docker stop kumori-postgrest
	@docker exec -u postgres kumori-postgres pg_dump --data-only -U "${POSTGRES_PASSWORD}" "${POSTGREST_CONNECTION_DB}" > dump.pgsql
	@docker start kumori-postgrest

test:
	@./ready.sh
	@docker run --rm -v ${PWD}/services/frontend:/tmp -w /tmp ${BUILD_IMAGE} npm run test
	services/backend/rest_test.sh eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiZWRpdG9yIn0.tYUlheVyisdr0ezFYf92mC_dvSS02cpDvPBu9aKLySk http://localhost:3000
	@docker exec kumori-integration bash -c 'cd services/spec && ./gradlew'

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
