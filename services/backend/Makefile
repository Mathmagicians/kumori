ORG=mathmagicians
APP=kumori_db
VERSION=latest
IMAGE=${ORG}/${APP}:${VERSION}

.PHONY: build shell run

build:
	@cat ./users.sql > schema.sql
	@cat ./database.sql >> schema.sql
	@cat ./functions/row_inserted.sql >> schema.sql
	@cat ./functions/row_updated.sql >> schema.sql
	@cat ./tables/api.taxonomy.sql >> schema.sql
	@cat ./tables/api.statuses.sql >> schema.sql
	@cat ./tables/api.scopes.sql >> schema.sql
	@cat ./tables/api.components.sql >> schema.sql
	@cat ./tables/api.comments.sql >> schema.sql
	@cat ./tables/api.links.sql >> schema.sql
	@cat ./tables/api.usecases.sql >> schema.sql
	@cat ./tables/api.usecase_taxonomy.sql >> schema.sql
	@cat ./tables/api.component_usecase.sql >> schema.sql
	@cat ./views/api.w_usecases.sql >> schema.sql
	@cat ./views/api.w_components.sql >> schema.sql
	@cat ./views/api.w_taxonomy.sql >> schema.sql
	@cat ./functions/api.search_component.sql >> schema.sql
	@docker build -t ${IMAGE} .
	@rm schema.sql

shell:
	@docker run --rm --name kumori_db_shell -it ${IMAGE} /bin/bash

run:
	@docker run --env-file .env --rm --name kumori_db_run -it ${IMAGE}
