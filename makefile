PROJECT_NAME="starterproject"
DOCKER_CONTAINER = $$(docker ps -a --format '{{ .ID }}' --filter name=${PROJECT_NAME})

# Make File template for the help command taken from here: https://gist.github.com/prwhite/8168133
.DEFAULT_GOAL := help

.PHONY: help
help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: start
start: ## Creates an image with target dev and then starts container
	docker build devops/ --target=development -t=${PROJECT_NAME}:dev
	$(MAKE) stop
	$(MAKE) cleanup
	docker run -d --name ${PROJECT_NAME} ${PROJECT_NAME}:dev

.PHONY: stop
stop: ## Stops the development container
	docker stop ${DOCKER_CONTAINER}

.PHONY: cleanup cl
cleanup cl: ## Removes created Container
	docker rm ${DOCKER_CONTAINER}

.PHONY: sys-cleanup sc
sys-cleanup sc: ## Removes the docker container and runs a system cleanup to remove unneeded images
	$(MAKE) stop
	$(MAKE) cleanup
	docker system prune -fa

.PHONY: build
build: ## Builds the docker-images to be used for production
	docker build devops/ --target=production -t=${PROJECT_NAME}:latest

.PHONY: lint
lint: ## Runs the Linters
	exit 0

.PHONY: test
test: ## Runs the (Unit-/Integration) Tests
	exit 0