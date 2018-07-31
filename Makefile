.PHONY: build sh test lint

version := latest
IMAGE := py

build:
	docker build -t $(IMAGE):$(version) .

sh: build
	docker run --rm -it -v $(HOME)/.kube:/root/.kube -v $$(pwd):/app -w /app $(IMAGE):$(version) /bin/bash

test: build
	docker run --rm -it -v $(HOME)/.kube:/root/.kube -v $$(pwd):/app $(IMAGE):$(version) python -m unittest

lint: build
	docker run --rm -it -v $(HOME)/.kube:/root/.kube -v $$(pwd):/app $(IMAGE):$(version) pylint ./run.py --disable=missing-docstring
