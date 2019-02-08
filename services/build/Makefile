ORG=mathmagicians
APP=kumori_build
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}

.PHONY: build run

build:
	@docker build -t ${IMAGE} .

preload: build
	@docker run --name build_preload --rm -d -v ${PWD}/../spec:/tmp -w /tmp ${IMAGE} tail -F /.dockerenv
	-@docker exec build_preload ./gradlew
	@docker export -o archive.tar build_preload
	@docker stop build_preload
	@docker import archive.tar ${IMAGE}
	@rm archive.tar

run:
	@docker run -e GITHUB_TOKEN -e TRAVIS_BUILD_NUMBER --rm -it -v ${PWD}/../:/tmp -w /tmp ${IMAGE}
