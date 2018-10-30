VERSION=latest
IMAGE="mathmagicians/meritocracy_web:${VERSION}"

.PHONY: setup build unit e2e test login logout push pull shell run

setup:
	@docker run --rm -dt --name setup -v ${PWD}:/tmp -w /tmp node
	@docker exec setup npm install
	@docker rm -f setup

unit:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run unit

e2e:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run e2e

rest:
	@../backend/rest_test.sh eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiZWRpdG9yIn0.tYUlheVyisdr0ezFYf92mC_dvSS02cpDvPBu9aKLySk http://localhost:3000

test: unit e2e

build:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node sed -i 's|http://127.0.0.1:3000/|api/|' src/api/server/index.js
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run build
	@docker build -t ${IMAGE} .
	@docker run --rm -v ${PWD}:/tmp -w /tmp node sed -i 's|api/|http://127.0.0.1:3000/|' src/api/server/index.js

login:
	@docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASS}

logout:
	@docker logout ${REGISTRY}

push:
	@docker push ${IMAGE}

pull:
	@docker pull ${IMAGE}

shell:
	@docker run --rm --name meritocracy_web_shell -it -p 80:80 node /bin/sh

run:
	@docker run --rm --name meritocracy_web_run -p 80:80 -it ${IMAGE}
