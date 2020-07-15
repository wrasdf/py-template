.PHONY: sh test lint server

DCB := docker-compose build
DCR := docker-compose run --rm

sh:
	$(DCB) sh
	$(DCR) sh

test:
	$(DCB) test
	$(DCR) test

lint:
	./bin/lint

server:
	./bin/server
