SHELL:=/bin/bash
TOP_DIR:=$(notdir $(CURDIR))
APP:=app

ifeq ($(VERSION),)
	VERSION:=$(shell git describe --tags --dirty --always)
endif


run-tests:
	go test -v ./...

install-go-tools:
	@./scripts/install_tools.sh
	go install github.com/golang/mock/mockgen

lint:
	golangci-lint run ./...

generate:
	go generate -v ./...

kind-create-cluster: 
	kind create cluster --name $(APP)-test

kind-delete-cluster:
	kind delete cluster --name $(APP)-test
