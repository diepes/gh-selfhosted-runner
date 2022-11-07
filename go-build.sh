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

#GH_RUNNER_VERSION="2.299.1"
#GH_RUNNER_SHA256="147c14700c6cb997421b9a239c012197f11ea9854cd901ee88ead6fe73a72c74"

echo "# GH_RUNNER_VERSION=${GH_RUNNER_VERSION}"
docker build \
    --build-arg RUNNER_VERSION=${GH_RUNNER_VERSION} \
    --build-arg RUNNER_SHA256=${GH_RUNNER_SHA256} \
    --tag diepes/github-runner-linux \
    .
