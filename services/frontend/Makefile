ORG=mathmagicians
APP=kumori_web
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}
BUILD_IMAGE=mathmagicians/kumori_build:latest

.PHONY: install build nuke_node peaceNode

install:
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm install

build:
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm run build
	@docker build -t ${IMAGE} .

nuke_node:
	@rm -rf node_modules

peaceNode: nuke_node install
