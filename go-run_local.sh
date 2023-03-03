#!/usr/bin/env bash
source config.env

set -x
docker run -it \
            -e GH_OWNER=${GH_OWNER} \
            -e GH_REPOSITORY=${GH_REPOSITORY} \
            -e GH_TOKEN=${GH_TOKEN} \
            -e GH_LABELS=${GH_LABELS} \
            -e GH_REMOVE="" \
            ${DOCKER_REPO}/${DOCKER_NAME}
