## FAERS-Quarterly

This repository is for exploratory analysis of the FAERS 2022 Q2 data extract files. I intend to use this project as an opportunity to teach myself about Make and DuckDB, as well as increase my knowledge of Docker.

## Usage

Clone the repo:
```sh
git clone https://github.com/adamferrick/faers-quarterly
cd faers-quarterly
```

Build the image:
```sh
make build
```

At the moment, the only other thing you can do is run the image interactively.

To launch a new container interactively:
```sh
make interactive
```