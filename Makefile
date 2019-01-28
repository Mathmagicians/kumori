.PHONY: build push sonar-scan

build:
	@cd services/build && \
	make -f Makefile build
	@cd services/backend && \
	make -f Makefile build
	@cd services/frontend && \
	make -f Makefile server_start setup build server_start

test:
	@cd services/frontend && \
	make -f Makefile rest unit
	@cd services/spec && \
	./gradlew

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
