VERSION=latest
IMAGE=kumori/development:${VERSION}

build:
	docker build -t ${IMAGE} .

test:
	@echo Java installed test:
	@test $(shell docker run -it ${IMAGE} | grep version | awk '{ print $$3 }' | sed 's/"//g') = 1.8.0_144 && echo Passed || echo Failed

console:
	docker run -it ${IMAGE} /bin/sh
