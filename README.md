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

### Command overview

| Command        		                  | Input(Files)                    |Input (Argumnts)                                   | Output                                                                                                        |
| ----------------------------------- | ------------------------------- |---------------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| [`./setup`](#setup-1)        		    | `./setup-betsy` `./setup-ode`	  |                                                   |Both docker images (`./Image/DockerFile`, `./Image/DockerFile_ode`) are installed                              |
| [`./setup-betsy`](#setup-betsy)     | `./image/Dockerfile`|           |The docker image `./Image/DockerFile` is installed |                                                                                                               |
| [`./setup-ode`](#setup-betsy)    		| `./image/Dockerfile_ode`        |                                                   |The docker image `./Image/DockerFile_ode` is installed                                                         |
| [`./betsy`](#betsy-1)						    | `./setup-betsy` `./common.sh`   | `bpel <Engine Group/Engine> <Process>`            |The process is executed on the engine and the logs are in the folder `./results/[Date in ms and arguments]`    |
| [`./betsy-ode`](#betsy-ode)				  | `./setup-ode` `./common.sh`     | `<Process>`                                       |The process is executed on the engine ODE and the logs are in the folder `./results/[Date in ms and arguments]`|


### Setup

#### Setup

This script `./setup` installs both docker images (`./image/DockerFile`, `./image/Dockerfile_ode`) by invoking the scripts `./setup-betsy` and `./setup-ode`.  Both scripts installs only the images the docker of the image folder.

#### Setup-betsy

`./setup-betsy` builds the docker image `./image/Dockerfile` with a installed openjdk8 and the installed betsy.

#### Setup-ode

`./setup-betsy` builds the docker image `./image/Dockerfile_ode` containing beside the openjdk8 and betsy the BPEL-engine [Apache ODE](http://ode.apache.org/). This has the benefit, that the engine doesn't have to be downloaded before test execution.

### Images

#### Betsy

The docker file for betsy `./image/Dockerfile` based on the docker file 'docker-oracle-jdk8'. The image contains the JDK8, which is a requirement for the execution of betsy. To install betsy updates are executed and git is installed in the case it isn't installed. After this step the version/commit [`8acee27`](https://github.com/uniba-dsg/betsy/commit/8acee27c88b8ceaa98c85865db502fa633f9f9b1) is cloned from the [github repository](https://github.com/uniba-dsg/betsy).

#### Ode

The image `./image/Dockerfile_ode` bases on the betsy image `./image/Dockerfile`. And extends only the betsy image with the step to download [Apache ODE](http://ode.apache.org/) by using the command `betsy engine ode install`. All betsy commands are listed in the betsy [repository](https://github.com/uniba-dsg/betsy#usage). The engine is downloaded from repository of the Distributed Systems Group (DSG). The extraction and start of the engine is part of the test procedure.

### Execution

#### Betsy

The `./betsy` script installs the docker image `./image./Dockerfile` for betsy in case it isn't installed. After installation the docker container is launched and betsy is started. To start betsy arguments are needed. The arguments are listed in the [repository](https://github.com/uniba-dsg/betsy#usage) of betsy. But you should only use commands for the execution of tests, because after the execution of the betsy command the logs of the test are transferred from the container to the folder, which name consists  of the  arguments and the date ins ms, in the directory `./results`. For example: `./reult/betsy-bpel-ode-sequence-1436402271` At least the html file is opened `./results/[Date in ms and arguments]/test/reports/results.html`.

`./betsy bpel <Engine Group|Engine> <Process>`

Examples:

	./betsy bpel ode sequence
	./betsy bpel ode ALL
	./betsy bpel ALL ALL

Relevant arguments:

| 				      		 | 				                      |
| :----------------- |:-----------------------------|
| Engine Groups      |ALL, LOCALS, VMS, RECENT      |
| Egnines            |ode, bpelg, openesb, petalsesb, orchestra, active-bpel, openesb23, openesb231, petalsesb41, ode136, ode-in-memory, ode136-in-memory, bpelg-in-memory, wso2_v3_1_0, wso2_v3_0_0, wso2_v2_1_2, ode_v, bpelg_v, openesb_v, petalsesb_v, orchestra_v, active_bpel_v         |
| Processes     		 |ALL, BASIC_ACTIVITIES_WAIT, BASIC_ACTIVITIES_THROW, BASIC_ACTIVITIES_RECEIVE, BASIC_ACTIVITIES_INVOKE, BASIC_ACTIVITIES_ASSIGN, BASIC_ACTIVITIES, SCOPES_EVENT_HANDLERS, SCOPES_FAULT_HANDLERS, SCOPES, STRUCTURED_ACTIVITIES_FLOW, STRUCTURED_ACTIVITIES_IF, STRUCTURED_ACTIVITIES_FOR_EACH, STRUCTURED_ACTIVITIES_PICK, STRUCTURED_ACTIVITIES, CONTROL_FLOW_PATTERNS, STATIC_ANALYSIS, SA00019, SA00018, SA00017, SA00012, SA00056, SA00011, SA00055, SA00010, SA00054, SA00053, SA00016, SA00015, SA00059, SA00014, SA00058, SA00013, SA00057, SA00063, SA00062, SA00061, SA00060, SA00023, SA00067, SA00022, SA00066, SA00021, SA00065, SA00020, SA00064, SA00025, SA00069, SA00024, SA00068, SA00070, SA00072, SA00071, SA00034, SA00078, SA00077, SA00032, SA00076, SA00037, SA00036, SA00035, SA00079, SA00081, SA00080, SA00085, SA00084, SA00083, SA00082, SA00008, SA00007, SA00006, SA00001, SA00045, SA00089, SA00044, SA00088, SA00087, SA00086, SA00005, SA00048, SA00003, SA00047, SA00002, SA00046, SA00092, SA00091, SA00090, SA00052, SA00051, SA00095, SA00050, SA00093, FAULTS, ERRORS, ...            |


#### Betsy-ode

This script `./betsy-ode` is similar to the `./betsy` script. There is only one difference. In the script `./betsy-ode` the engine is determined as [ODE](http://ode.apache.org/). So you have only to choose the test process or process group.

`./betsy-ode <Process>`

Examples:

	./betsy-ode sequence
	./betsy-ode ALL

Relevant arguments:

|               		 | 			                        |
| :----------------- |:-----------------------------|
| Processes     		 |ALL, BASIC_ACTIVITIES_WAIT, BASIC_ACTIVITIES_THROW, BASIC_ACTIVITIES_RECEIVE, BASIC_ACTIVITIES_INVOKE, BASIC_ACTIVITIES_ASSIGN, BASIC_ACTIVITIES, SCOPES_EVENT_HANDLERS, SCOPES_FAULT_HANDLERS, SCOPES, STRUCTURED_ACTIVITIES_FLOW, STRUCTURED_ACTIVITIES_IF, STRUCTURED_ACTIVITIES_FOR_EACH, STRUCTURED_ACTIVITIES_PICK, STRUCTURED_ACTIVITIES, CONTROL_FLOW_PATTERNS, STATIC_ANALYSIS, SA00019, SA00018, SA00017, SA00012, SA00056, SA00011, SA00055, SA00010, SA00054, SA00053, SA00016, SA00015, SA00059, SA00014, SA00058, SA00013, SA00057, SA00063, SA00062, SA00061, SA00060, SA00023, SA00067, SA00022, SA00066, SA00021, SA00065, SA00020, SA00064, SA00025, SA00069, SA00024, SA00068, SA00070, SA00072, SA00071, SA00034, SA00078, SA00077, SA00032, SA00076, SA00037, SA00036, SA00035, SA00079, SA00081, SA00080, SA00085, SA00084, SA00083, SA00082, SA00008, SA00007, SA00006, SA00001, SA00045, SA00089, SA00044, SA00088, SA00087, SA00086, SA00005, SA00048, SA00003, SA00047, SA00002, SA00046, SA00092, SA00091, SA00090, SA00052, SA00051, SA00095, SA00050, SA00093, FAULTS, ERRORS, ...            |
