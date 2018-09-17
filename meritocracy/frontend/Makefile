.PHONY: setup build unit e2e test serve-start serve-logs serve-stop shell

setup:
	@docker run --rm -dt --name setup -v ${PWD}:/tmp -w /tmp node
	@docker exec setup npm install
	@docker rm -f setup

build:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run build

unit:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run unit

e2e:
	@docker run --rm -v ${PWD}:/tmp -w /tmp node npm run e2e

test: unit e2e

serve-start:
	@docker run  --rm -dt --name serve -v ${PWD}:/tmp -w /tmp -p 8080:8080 node npm run dev

serve-logs:
	@docker logs serve -f

serve-stop:
	@docker rm -f serve

shell:
	@docker run --rm -it -v ${PWD}:/tmp -w /tmp -p 8080:8080 node bash
