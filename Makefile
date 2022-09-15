PROJECT_NAME = faers-exploratory
VOLUMES = -v "${CURDIR}/data:/home/analysis/data" -v "${CURDIR}/notebooks:/home/analysis/notebooks" -v "${CURDIR}/reports:/home/analysis/reports" -v "${CURDIR}/src:/home/analysis/src"



.PHONY: help build interactive clean

help: ## print this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help



.docker-buildstamp: Dockerfile ## build the image
	docker build -t $(PROJECT_NAME) .
	touch .docker-buildstamp

interactive: .docker-buildstamp ## launch the container and start an interactive bash shell
	docker run -ti --rm $(VOLUMES) $(PROJECT_NAME) /bin/bash

clean: ## cleans up reports/, data/, notebooks/ and removes the docker image
	find . -name "*.zip" -type f -delete
	find . -name "*.duckdb" -type f -delete
	find . -name "*.html" -type f -delete
	docker rmi faers-exploratory
	find . -name ".docker-buildstamp" -type f -delete

all: notebooks/zantac.html notebooks/metrics.html ## runs the analysis pipeline


data/faers_ascii_2022q2.zip: .docker-buildstamp
	docker run --rm $(VOLUMES) $(PROJECT_NAME) wget --no-use-server-timestamps -O data/faers_ascii_2022q2.zip https://fis.fda.gov/content/Exports/faers_ascii_2022q2.zip

data/faers_22q2.duckdb: data/faers_ascii_2022q2.zip
	docker run --rm $(VOLUMES) $(PROJECT_NAME) Rscript src/create_database.R

%.html: %.Rmd data/faers_22q2.duckdb
	docker run --rm $(VOLUMES) $(PROJECT_NAME) Rscript -e "rmarkdown::render('$<')"
