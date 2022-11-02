#!/usr/bin/env bash
#Build container: docker build [OPTIONS] PATH
# https://github.com/actions/runner/releases

RUNNER_VERSION="2.298.2"
RUNNER_SHA256="0bfd792196ce0ec6f1c65d2a9ad00215b2926ef2c416b8d97615265194477117"
docker build \
    --build-arg RUNNER_VERSION=${RUNNER_VERSION} \
    --build-arg RUNNER_SHA256=${RUNNER_SHA256} \
    --tag diepes/github-runner-linux \
    .
