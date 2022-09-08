## FAERS-Exploratory

This repository is for exploratory analysis of the FAERS 2022 Q2 data extract files. I intend to use this project as an opportunity to teach myself about Make and DuckDB, as well as increase my knowledge of Docker.

## Usage

Clone the repo:
```sh
git clone https://github.com/adamferrick/faers-exploratory
cd faers-quarterly
```

Build the image:
```sh
make build
```

Once the image is built, you can run any of the notebooks.
```sh
make notebooks/zantac.html
```
This will download the data, populate the database, and render the notebook. To view it, simply open the resultant html file in a web browser.

You can also run the image interactively.

To launch a new container interactively:
```sh
make interactive
```

The following command will remove the data and rendered reports from your system:
```sh
make clean
```