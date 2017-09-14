VERSION=latest
IMAGE=kumori/development:${VERSION}

.PHONY: setup build test console confluence_setup

setup:
	mkdir -p /tmp/atlassian/confluence
	chmod -R 777 /tmp/atlassian/confluence

build:
	docker build -t ${IMAGE} .

confluence_setup:
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"key":"KUMO","name":"Kumori","type":"global","description":{"plain":{"value":"kumori","representation":"plain"}}}' http://localhost:8090/rest/api/space
	curl -s -u admin:admin -X POST -H 'Content-Type: application/json' -d '{"type":"page","title":"Kumori","space":{"key":"KUMO"},"body":{"storage":{"value":"<h1>Kumori</h1>","representation":"storage"}}}' http://localhost:8090/rest/api/content/
test:
	@echo Java installed test:
	@test $(shell docker run -it ${IMAGE} | grep version | awk '{ print $$3 }' | sed 's/"//g') = 1.8.0_144 && echo Passed || echo Failed

console:
	docker run -it ${IMAGE} /bin/sh
