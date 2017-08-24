VERSION=latest
IMAGE=kumori/development:${VERSION}

build:
	docker build -t ${IMAGE} .

console:
	docker run -it ${IMAGE} /bin/sh
