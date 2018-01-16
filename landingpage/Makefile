build:
	docker build -t dk.mathmagicians/kumori/landing:latest .

start:
	@docker run \
	--name landing \
	-d \
	--rm  \
	-p 10001:80 dk.mathmagicians/kumori/landing:latest

stop:
	@docker stop landing

restart: stop start
