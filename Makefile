.PHONY: sh ut lint

DCB := docker-compose build
DCR := docker-compose run --rm

sh:
	$(DCB) sh
	$(DCR) sh

test:
	$(DCB) test
	$(DCR) test

localdb:
	./bin/local-db

server:
	./bin/server

build-%:
	docker build -t $(IMAGE):$(*) .
	docker tag $(IMAGE):$(*) $(IMAGE):latest
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(*)
