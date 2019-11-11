.PHONY: sh ut lint

IMAGE := ikerry/aws-es-proxy
DCB := docker-compose build
DCR := docker-compose run --rm

ut:
	$(DCB) ut
	$(DCR) ut

lint:
	$(DCB) lint
	$(DCR) lint

sh:
	$(DCB) sh
	$(DCR) sh

build-%:
	docker build -t $(IMAGE):$(*) .
	docker tag $(IMAGE):$(*) $(IMAGE):latest
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(*)
