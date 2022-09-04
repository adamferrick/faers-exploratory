PROJECT_NAME = faers-exploratory
VOLUMES = -v "${CURDIR}/data:/home/analysis/data" -v "${CURDIR}/notebooks:/home/analysis/notebooks" -v "${CURDIR}/reports:/home/analysis/reports" -v "${CURDIR}/src:/home/analysis/src"



.PHONY: help build interactive

help: ## print this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help



build: ## build the image
	docker build -t $(PROJECT_NAME) .

interactive: ## launch the container and start an interactive bash shell
	docker run -ti $(VOLUMES) $(PROJECT_NAME) /bin/bash