#!/usr/bin/env bash
#Build container: docker build [OPTIONS] PATH
# https://github.com/actions/runner/releases
docker build --build-arg RUNNER_VERSION=2.298.2 --tag diepes/github-runner-linux .
