ORG=mathmagicians
APP=kumori-build
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}

.PHONY: build run

build:
	@docker build -t ${IMAGE} .

push:
	@docker push ${IMAGE}

run:
	@docker run -e GITHUB_TOKEN -e TRAVIS_BUILD_NUMBER --rm -it -v ${PWD}/../:/tmp -w /tmp ${IMAGE}
