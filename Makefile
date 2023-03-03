# Note Makefile (DiePes)
#	use TABs to indent action lines (rm, tar, g++ etc.)
#	use $(FOO) to expand variable FOO instead of ${FOO} or $FOO
#	add dependencies where relevant.

# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# # import deploy config
# # You can change the default deploy config with `make cnf="deploy_special.env" release`
# dpl ?= deploy.env
# include $(dpl)
# export $(shell sed 's/=.*//' $(dpl))

# grep the version from the mix file
VERSION=$(shell ./version.sh)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


# DOCKER TASKS
# Build the container
build: ## Build the container.
	docker build \
		--build-arg RUNNER_VERSION=$(GH_RUNNER_VERSION) \
		--build-arg RUNNER_SHA256=$(GH_RUNNER_SHA256) \
		--tag $(DOCKER_REPO)/$(APP_NAME) \
		.


run: ## Run container build by build command
	docker run -it \
	        -e GH_OWNER=$(GH_OWNER) \
			-e GH_REPOSITORY=$(GH_REPOSITORY) \
			-e GH_OWNER=$(GH_OWNER) \
			-e GH_TOKEN=$(GH_TOKEN) \
			$(DOCKER_REPO)/$(APP_NAME)

run-debug: ## Run container build by build command
	docker run -it \
	        -e GH_OWNER=$(GH_OWNER) \
			-e GH_REPOSITORY=$(GH_REPOSITORY) \
			-e GH_OWNER=$(GH_OWNER) \
			-e GH_TOKEN=$(GH_TOKEN) \
			--entrypoint="/bin/bash" \
			$(DOCKER_REPO)/$(APP_NAME)

# publish-latest: tag-latest ## Publish the `latest` taged container to ECR
#     @echo 'publish latest to $(DOCKER_REPO)'
#     docker push $(DOCKER_REPO)/$(APP_NAME):latest
