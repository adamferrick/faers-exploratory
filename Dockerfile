FROM rocker/r-ver:4.2.1

# install system dependencies
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    pandoc

# intall R package binaries for Ubuntu 20.04 (Focal) from RSPM (2022-09-02 snapshot)
RUN echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/2022-09-02+Y3JhbiwyOjQ1MjYyMTU7NDRDNEZGNjk"))' \
    >> "${R_HOME}/etc/Rprofile.site"

RUN install2.r --error --skipinstalled --ncpus -1 \
    tidyverse \
    rmarkdown \
    duckdb \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so

RUN mkdir /home/analysis
WORKDIR /home/analysis