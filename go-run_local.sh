#!/usr/bin/env bash
source config.env

docker run -it -e GH_OWNER=${GH_OWNER} \
               -e GH_REPOSITORY=${GH_REPOSITORY} \
               -e GH_TOKEN=${GH_TOKEN} \
               -e GH_LABELS=${GH_LABELS} \
               -e GH_REMOVE="" \
               docker.io/diepes/github-runner-linux
