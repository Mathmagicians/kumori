.PHONY: build push sonar-scan

build:
	@cd meritocracy/backend/postgres && \
	make -f Makefile build
	@cd meritocracy/frontend && \
	make -f Makefile setup build

test:
	@cd meritocracy/frontend && \
	make -f Makefile rest unit
	@cd meritocracy/spec && \
	./gradlew

get_release:
	curl -s -X GET https://${GITHUB_TOKEN}@api.github.com/repos/Mathmagicians/kumori/releases/tags/${GITHUB_TAG} | GREP_OPTIONS='' grep -m 1 id | grep -o '[0-9]*'

tag:
	curl -X DELETE /repos/:owner/:repo/releases/:release_id
	curl -X POST https://${GITHUB_TOKEN}@api.github.com/repos/Mathmagicians/kumori/releases -d "{\"tag_name\": \"${GITHUB_TAG}\",\"target_commitish\": \"master\",\"name\": \"v1.0.0-snapshot\",\"body\":\"Description of the release\",\"draft\": false,\"prerelease\":false}"

push:
	@cd meritocracy/backend/postgres && \
	make -f Makefile push
	@cd meritocracy/frontend && \
	make -f Makefile push

sonar-scan:
	@docker run \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:1.1.2 \
	 -Dsonar.login=${SONARCLOUD_TOKEN}
