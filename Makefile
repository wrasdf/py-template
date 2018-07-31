build:
	docker build -t py .

sh: build
	docker run --rm -it -v $(HOME)/.kube:/root/.kube -v $$(pwd):/app -w /app py /bin/bash

lint: build
	docker run --rm -it -v $(HOME)/.kube:/root/.kube -v $$(pwd):/app py:latest pylint ./run.py --disable=missing-docstring
