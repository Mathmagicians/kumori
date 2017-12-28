autofix:
	@docker run --rm -v ${PWD}:/data -w /data php_parser_image phpcbf.phar
	@docker run --rm -v ${PWD}:/data -w /data php_parser_image phpcs.phar
	@docker run --rm -v ${PWD}:/data -w /data php_parser_image php-cs-fixer.phar fix .

setup-php:
	docker run -u=$(shell echo $$UID) --rm -v $(shell pwd):/data -w /data php_parser_image composer.phar update

build:
	docker build -t php_parser_image .
