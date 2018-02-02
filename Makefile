SHELL = /bin/bash -O extglob -O globstar -c

.PHONY : shellcheck oci-from-buildah oci-from-dockerfile docker-from-buildah docker-from-dockerfile

.DEFAULT_GOAL = help

## Lint scripts
shellcheck:
	@env shellcheck -x ./**/*.sh

## OCI image from a sequence of `buildah` commands
oci-from-buildah:
	@./scripts/build/with-buildah-create.sh 'oci'

## OCI image from `buildah bud` Dockerfile conversion
oci-from-dockerfile:
	@./scripts/build/buildah-convert-dockerfile.sh

## Docker image from `buildah bud` Dockerfile conversion
docker-from-buildah:
	@./scripts/build/with-buildah-create.sh 'docker'

## Docker image using `docker`
docker-from-dockerfile:
	@docker build -t nginx:docker scripts/build

## Show help screen
help:
	@echo "Please use \`make <target>' where <target> is one of\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
