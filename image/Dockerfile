# This is a Dockerfile to create an image with betsy installed.

# Version 1.0

# oracle-jdk-8 required!
FROM kurron/docker-oracle-jdk-8

MAINTAINER Simon Harrer (simon.harrer@uni-bamberg.de)

# make everything up to date
RUN apt-get update &&\
    apt-get -y upgrade &&\
    apt-get clean

# git
RUN apt-get update &&	apt-get install -y git

RUN apt-get update && apt-get install -y openjdk-7-jre

ENV JAVA7_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre

# when copying the Dockerfile in the repo, this is no longer necessary
# see http://stackoverflow.com/questions/27482504/dockerfile-cannot-access-git-repo-with-my-private-key
RUN mkdir ~/.ssh
RUN ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts
RUN git clone https://github.com/uniba-dsg/betsy && cd betsy && git checkout 3807c1760dd2ae3d21cb7ab2f9df04c4e430aa24

WORKDIR betsy

# build betsy
RUN ./gradlew installApp
