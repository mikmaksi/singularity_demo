#!/bin/bash

# build a docker image with Singularity is installed
# pass our user name and id at runtime to fix file ownership
docker build \
    --build-arg user=$USER \
    --build-arg uid=$UID \
    -t singularity .
