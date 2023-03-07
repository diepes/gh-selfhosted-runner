#!/usr/bin/env bash
#Build container: docker build [OPTIONS] PATH
# https://github.com/actions/runner/releases
if [[ -f config.env ]]; then
    source config.env
else
    cp config.template.env config.env
    echo "# Created config.env from config.tpl.env please update values and run again."
    echo "# ERROR"
    exit 1
fi

echo "# GH_RUNNER_VERSION=${GH_RUNNER_VERSION}  RUNNER_SHA256=${GH_RUNNER_SHA256}"
tag="$( date +%Y%m%dT%Hh%M )-${GH_RUNNER_VERSION}"
docker build \
    --build-arg RUNNER_VERSION=${GH_RUNNER_VERSION} \
    --build-arg RUNNER_SHA256=${GH_RUNNER_SHA256} \
    --tag ${DOCKER_REPO}/${DOCKER_NAME}:latest \
    --tag ${DOCKER_REPO}/${DOCKER_NAME}:${tag} \
    .

if [[ $? -ne 0 ]]; then exit 1; fi
echo
echo "# Now push to container registry ${DOCKER_REPO}/${DOCKER_NAME}"
docker push ${DOCKER_REPO}/${DOCKER_NAME}:${tag}
docker push ${DOCKER_REPO}/${DOCKER_NAME}:latest
