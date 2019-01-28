.PHONY: build push sonar-scan

build:
	@cd services/build && \
	make -f Makefile build
	@cd services/backend && \
	make -f Makefile build
	@cd services/frontend && \
	make -f Makefile server_start setup build server_start

build_build:
	@docker run -v ${PWD}:/tmp -w /tmp --name build_build mathmagicians/kumori_build:latest bash -c 'cd services/spec && ./gradlew'

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
