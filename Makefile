REPO=geppettoapps/crow

TAG=latest

.PHONY: all
all:
	make build

.PHONY: build
build:
	docker build -t $(REPO):$(TAG) .

.PHONY: push
push:
	docker push $(REPO):$(TAG)
