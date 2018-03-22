VERSION=latest
IMAGE=kumori/development:${VERSION}

.PHONY: build test console

build:
	docker build -t ${IMAGE} .

test:
	@echo Java installed test:
	@test $(shell docker run -it ${IMAGE} | grep version | awk '{ print $$3 }' | sed 's/"//g') = 9.0.4 && echo Passed || echo Failed

console:
	docker run -it ${IMAGE} /bin/sh
