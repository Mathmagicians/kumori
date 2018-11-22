.PHONY: build push sonar-scan

build:
	@cd meritocracy/backend/postgres && \
	make -f Makefile build
	@cd meritocracy/frontend && \
	make -f Makefile setup build

push:
	@cd meritocracy/backend/postgres && \
	make -f Makefile push
	@cd meritocracy/frontend && \
	make -f Makefile push

test:
	@cd meritocracy/frontend && \
	make -f Makefile rest unit
	@cd meritocracy/spec && \
	./gradlew

sonar:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
