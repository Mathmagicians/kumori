ORG=mathmagicians
APP=kumori_web
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}
BUILD_IMAGE=mathmagicians/kumori_build:latest

.PHONY: install build nuke_node peaceNode

build_image:
	@docker build --target development -t ${BUILD_IMAGE} .

install: build_image
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm install

build:
	@docker build --target prod -t ${IMAGE} .

test:
	@docker run --rm -v ${PWD}:/tmp -w /tmp ${BUILD_IMAGE} npm run test:unit

clean:
	@if [ -d "node_modules" ]; then rm -rf node_modules; fi
