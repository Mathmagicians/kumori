BUILD_IMAGE=mathmagicians/kumori-build:latest
VERSION=latest
IMAGE="mathmagicians/meritocracy_web:${VERSION}"

.PHONY: server_start server_shell server_stop setup build unit e2e test login logout push pull

# Start docker image for development
server_start:
	@docker run \
	-e GITHUB_TOKEN \
	-e TRAVIS_BUILD_NUMBE --rm -dt --name kumori_dev_server -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE}

# Run shell on dev server
server_shell:
	@docker exec -i -t kumori_dev_server bash

# Stop dev server
server_stop:
	@docker rm -f kumori_dev_server

setup:
	@docker exec kumori_dev_server npm install
	@docker exec kumori_dev_server sed -i '32893s/^/\/\//' node_modules/prettier/index.js

build:
	@docker exec kumori_dev_server sed -i 's|BASE_URL=".*"|BASE_URL="/api/"|' src/api/server/index.js
	@docker exec kumori_dev_server npm run build
	@docker build -t ${IMAGE} .
	@docker exec kumori_dev_server sed -i 's|BASE_URL=".*"|BASE_URL="http://127.0.0.1:3000/"|' src/api/server/index.js

nuke_node:
	@docker exec kumori_dev_server rm -rf node_modules

peaceNode: nuke_node setup

unit:
	@docker exec kumori_dev_server npm run test

e2e:
	@docker exec kumori_dev_server npm run test:e2e

test: unit e2e

login:
	@docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}

logout:
	@docker logout ${REGISTRY}

push:
	@docker push ${IMAGE}

pull:
	@docker pull ${IMAGE}
