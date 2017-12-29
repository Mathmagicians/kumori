G_DATA=grafana-data
P_DATA=postgres-data
A_DATA=pgadmin-data
S_DATA=sonarqube-data
N_DATA=neo4j-data
REPO=$(shell pwd)
VERSION=latest
IMAGE=kumori/development:${VERSION}

.PHONY: setup build test console confluence_setup

setup:
	mkdir -p /tmp/atlassian/confluence
	chmod -R 777 /tmp/atlassian/confluence

build:
	docker build -t ${IMAGE} .

confluence_setup:
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"key":"KUMO","name":"Kumori","type":"global","description":{"plain":{"value":"kumori","representation":"plain"}}}' http://localhost:8090/rest/api/space
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<h1>Kumori</h1>","representation":"storage"}}}' http://localhost:8090/rest/api/content/

confluence_test:
	curl -u admin:admin -X PUT -H 'Content-Type: application/json' -d'{"id":"720904","type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<i class=\"test\">test</i>","representation":"storage"}},"version":{"number":3}}' http://localhost:8090/rest/api/content/720904

test:
	@echo Java installed test:
	@test $(shell docker run -it ${IMAGE} | grep version | awk '{ print $$3 }' | sed 's/"//g') = 9.0.1 && echo Passed || echo Failed

console:
	docker run -it ${IMAGE} /bin/sh

autofix:
	@cd parser && make -f Makefile autofix

clean-all:
	rm -rf ${G_DATA} ${P_DATA} ${A_DATA}

build: build-parser-image setup-php-app

build-parser-image:
	@cd parser && make -f Makefile build

setup-php-app:
	@cd parser && make -f Makefile setup-php

bootstrap: bootstrap-postgres bootstrap-grafana

bootstrap-grafana:
	cd ./grafana && ./bootstrap-grafana.sh

bootstrap-postgres:
	cd ./postgres && make -f Makefile setup

bootstrap-sonarqube:
	cd ./sonarqube && ./bootstrap-sonarqube.sh

populate:
	@docker run -it \
	 --network=bodhi_backend \
	 --rm \
	 --name populate \
	 -v $(shell pwd):/usr/src/myapp \
	 -v ${REPO}:/usr/src/repo \
	 -w /usr/src/myapp php_parser_image:latest php parser/populate.php parse

sonar-scan:
	@docker run \
	 --network=bodhi_backend \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -e "SONAR_HOST=http://sonarqube:9000" \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:3.0.3.778
