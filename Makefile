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

<<<<<<< HEAD
test:
	@cd meritocracy/frontend && \
	make -f Makefile rest unit
	@cd meritocracy/spec && \
	./gradlew

=======
>>>>>>> bd3020a38153ad882967a231ccb50b064b6a2e0f
sonar-scan:
	@docker run \
	 --network=kumori_backend \
	 --rm \
	 --user $(shell id -u):$(shell id -g) \
	 -e "SONAR_HOST=http://sonarqube:9000" \
	 -v $(shell pwd):/data \
	 -w /data localgod/docker-sonarqube-scanner:3.0.3.778
