VERSION=latest
IMAGE="mathmagicians/meritocracy_spec:${VERSION}"

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
	@docker run --rm --name meritocracy_int_shell -it ${IMAGE} /bin/sh

run:
	@docker run --rm --name meritocracy_int_run ${IMAGE}
