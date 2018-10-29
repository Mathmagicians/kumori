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

sonar-scan:
	@docker run \
	 --network=kumori_backend \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -e "SONAR_HOST=http://sonarqube:9000" \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:3.0.3.778
