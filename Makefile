REPO=$(shell pwd)

.PHONY: populate sonar-scan

populate:
	@docker run -it \
	 --network=kumori_backend \
	 --rm \
	 --name populate \
	 -v $(shell pwd):/usr/src/myapp \
	 -v ${REPO}:/usr/src/repo \
	 -w /usr/src/myapp php_parser_image:latest php parser/populate.php parse

sonar-scan:
	@docker run \
	 --network=kumori_backend \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -e "SONAR_HOST=http://sonarqube:9000" \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:3.0.3.778
