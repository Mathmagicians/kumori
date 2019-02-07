ORG=mathmagicians
APP=kumori_web
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}
BUILD_IMAGE=mathmagicians/kumori_build:latest

.PHONY: install build nuke_node peaceNode

install:
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm install
# https://stackoverflow.com/questions/52202399/typeerror-super-expression-must-either-be-null-or-a-function/52204427
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} sed -i '32893s/^/\/\//' node_modules/prettier/index.js

build:
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} sed -i 's|BASE_URL=".*"|BASE_URL="/api/"|' src/api/server/index.js
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm run build
	@docker build -t ${IMAGE} .
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} sed -i 's|BASE_URL=".*"|BASE_URL="http://127.0.0.1:3000/"|' src/api/server/index.js

nuke_node:
	@rm -rf node_modules

peaceNode: nuke_node install
