# betsy + docker

This repo contains both the Dockerfile and scripts to run a betsy command in docker.

## Quickstart

### Prerequisites

- Docker installed

### Usage

	setup # creates all docker images
	setup-betsy # creates the betsy image with betsy installed and compiled
	setup-ode # creates the betsy-ode image with Apache ODE 1.3.5 already installed with betsy

	betsy ARGS # executes betsy ARGS on `setup-betsy`
	betsy-ode PROCESS # executes a single PROCESS on `setup-ode`

	# Examples
	betsy bpel ode sequence
	betsy engine ode install
	betsy-ode sequence

### Output

- under `results` will be the results of a particular test run.

## Documentation

### Setup

#### Setup

This script `setup` installs both docker images by invoking the scripts setup-betsy and setup-ode.  Both scripts installs only the images the docker of the image folder.

#### Setup-betsy

`Setup-betsy` builds the docker image with a installed openjdk8 and the installed betsy.

#### Setup-ode

`Setup-betsy` builds the docker images containing beside the openjdk8 and betsy the BPEL-engine [Apache ODE](http://ode.apache.org/). This has the advantage, that the engine doesn't have to be downloaded before test execution.

### Images

#### Betsy

The docker file for betsy `Dockerfile` based on the docker file `docker-oracle-jdk8`. The image contains the JDK8, which is a requirement for the execution of betsy. To install betsy updates are executed and git is installed in the case it isn't installed. After this step the version/commit [`8acee27`](https://github.com/uniba-dsg/betsy/commit/8acee27c88b8ceaa98c85865db502fa633f9f9b1) is cloned from the [github repository](https://github.com/uniba-dsg/betsy).

#### Ode

The image `Dockerfile_ode` bases on the betsy image. And extends only the betsy image with the step to download [Apache ODE](http://ode.apache.org/) by using the command `betsy engine ode install`. All betsy commands are listed in the betsy [repository](https://github.com/uniba-dsg/betsy#usage). The engine is downloaded from repository of the Distributed Systems Group (DSG). The extraction and start of the engine is part of the test procedure.

### Execution

#### Betsy

This script installs the docker image `Dockerfile` for betsy in case it isn't installed. After installation the docker container is launched and betsy is started. To start betsy arguments are needed. The arguments are listed in the [repository](https://github.com/uniba-dsg/betsy#usage) of betsy. But you should only use commands for the exectuion of tests, because after the execution of the betsy command the logs of the test are transferred form the container to the folder, which name consists  of the  arguments and the date ins ms. For example: `betsy-bpel-ode-sequence-1436402271` At least the html file is opened `[Date in ms and arguments]/test/reports/results.html`.

#### Betsy-ode

This script is similar to the `betsy` script. There is only one difference. In the script `betsy-ode` the engine is determined as [ODE](http://ode.apache.org/). So you have only to choose the test process or process group.
