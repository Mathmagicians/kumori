VERSION=latest
IMAGE=dk.mathmagicians/kumori/landing:${VERSION}

build:
	docker build -t ${IMAGE} .

start:
	@docker run \
	--name landing \
	-d \
	--rm  \
	-p 10001:80 dk.mathmagicians/kumori/landing:latest

stop:
	@docker stop landing

restart: stop start

console:
	docker run --rm -it --entrypoint=/bin/sh ${IMAGE}
