# betsy + docker [![](https://badge.imagelayers.io/simonharrer/betsy-docker:latest.svg)](https://imagelayers.io/?images=simonharrer/betsy-docker:latest 'Get your own badge on imagelayers.io')

This repo contains both the Dockerfile and scripts to run a betsy command in Docker.

## Quickstart

### Prerequisites

- Docker 1.8.3 or later installed

### Usage

	setup # creates the betsy image with betsy installed and compiled
	betsy ARGS # executes betsy ARGS on `setup-betsy`
	docker-remove-all-stopped-containers # removes all stopped containers to free disk space

	# Examples
	betsy bpel ode__1_3_6 sequence
	betsy engine ode__1_3_6 install

	# generates Dockerfiles and start scripts for all engines
	ruby generate-dockerfile-per-engine.rb

	# generated files from the generate-dockerfile-per-engine.rb script
	setup-all # sets up all docker images
	setup-ENGINE # sets up the docker image for ENGINE
	betsy-ENGINE # allows to test ENGINE
	
	# Examples
	setup-ode1_3_6 # creates the betsy-ode image with Apache ODE 1.3.6 already installed with betsy
	betsy-ode1_3_6 sequence # executes the process sequence on engine ode1_3_6

### Output

- under `results` will be the results of a particular test run.

## Documentation

### Command overview

| Command        		                  | Input(Files)                    |Input (Arguments)                                   | Output                                                                                                        |
| ----------------------------------- | ------------------------------- |---------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| [`./setup`](#setup)     | `./image/Dockerfile`|           |The docker image `./Image/DockerFile` is installed |                                                                                                               |
| [`./betsy`](#betsy)						    | `./setup` `./common.sh`   | `bpel <engine(s)> <process(es)>`            |The process is executed on the engine and the logs are in the folder `./results/[Date in ms and arguments]`    |
| [`./setup-ENGINE`](#setup-engine)    		| `./image/Dockerfile_ENGINE`        |                                                   |The docker image `./Image/DockerFile_ENGINE` is installed                                                         |
| [`./betsy-ENGINE`](#betsy-engine)				  | `./setup-ENGINE` `./common.sh`     | `<process>`                                       |The process is executed on ENGINE and the logs are in the folder `./results/[Date in ms and arguments]`|


### setup

`./setup` builds the docker image `./image/Dockerfile` with a installed openjdk8 and the installed betsy.

### betsy

The docker file for betsy `./image/Dockerfile` based on the docker file 'docker-oracle-jdk8'. The image contains the JDK8, which is a requirement for the execution of betsy. To install betsy updates are executed and git is installed in the case it isn't installed. After this step a specific commit is cloned from the [github repository](https://github.com/uniba-dsg/betsy).


The `./betsy` script installs the docker image `./image./Dockerfile` for betsy in case it isn't installed. After installation the docker container is launched and betsy is started. To start betsy arguments are needed. The arguments are listed in the [repository](https://github.com/uniba-dsg/betsy#usage) of betsy. But you should only use commands for the execution of tests, because after the execution of the betsy command the logs of the test are transferred from the container to the folder, which name consists  of the  arguments and the date ins ms, in the directory `./results`. For example: `./reult/betsy-bpel-ode-sequence-1436402271` At least the html file is opened `./results/[Date in ms and arguments]/test/reports/results.html`.

`./betsy bpel <engine> <process>`

Examples:

	./betsy bpel ode sequence
	./betsy bpel ode ALL
	./betsy bpel ALL ALL

### setup-ENGINE

`./setup-ENGINE` builds the docker image `./image/Dockerfile_ENGINE` which installs the ENGINE ontop of the `betsy` image. 

### betsy-ENGINE

This script `./betsy-ENGINE` is similar to the `./betsy` script. There is only one difference. In the script `./betsy-ENGINE` the engine is already installed. So you have only to choose the test process. Only a single test can be executed in this configuration, not multiple test cases or groups of test cases!

`./betsy-ENGINE <process>`

Examples:

	./betsy-ENGINE sequence

## How to setup docker

	# install Docker Toolbox

	# remove previously created image
	docker-machine rm default

	# create image with larger disk space
	docker-machine create --virtualbox-disk-size "80000" --driver virtualbox default

	# setup env
	eval "$(docker-machine env default)"
