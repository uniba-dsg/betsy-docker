# betsy + docker

This repo contains both the Dockerfile and scripts to run a betsy command in docker.

## Prerequisites

- Docker installed

## Usage

	setup # creates all docker images
	setup-betsy # creates the betsy image with betsy installed and compiled
	setup-ode # creates the betsy-ode image with Apache ODE 1.3.5 already installed with betsy

	betsy ARGS # executes betsy ARGS on `setup-betsy`
	betsy-ode PROCESS # executes a single PROCESS on `setup-ode`

	# Examples
	betsy bpel ode sequence
	betsy engine ode install
	betsy-ode sequence

## Output

- under `results` will be the results of a particular test run. 