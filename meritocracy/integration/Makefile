VERSION=latest
IMAGE="mathmagicians/meritocracy_integration:${VERSION}"

.PHONY: login logout build push pull run console

build:
	@docker build -t ${IMAGE} .

login:
	@docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}

logout:
	@docker logout ${REGISTRY}

push:
	@docker push ${IMAGE}

pull:
	@docker pull ${IMAGE}

shell:
	@docker run --rm --name meritocracy_int_shell -it ${IMAGE} /bin/bash

run:
	@docker run --env-file .env --rm --name meritocracy_int_run -it ${IMAGE}
