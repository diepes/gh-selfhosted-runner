# base image (2022 no M1 support yet)
FROM --platform=linux/amd64 ubuntu:20.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ARG RUNNER_SHA256
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="Pieter Smit"
LABEL Email="github@vigor.nz"
LABEL GitHub="https://github.com/diepes"
LABEL BaseImage="ubuntu:20.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages + add a non-sudo user
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
       curl wget unzip vim git azure-cli jq build-essential libssl-dev libffi-dev \
       nodejs \
       python3 python3-venv python3-dev python3-pip

# docker user, github actions runner download and dependencies install
RUN useradd -m docker \
    && cd /home/docker \
    && mkdir actions-runner \
    && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && echo "${RUNNER_SHA256}  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && rm ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && chown -R docker ~docker \
    && /home/docker/actions-runner/bin/installdependencies.sh

COPY entrypoint.sh entrypoint.sh
USER docker
ENTRYPOINT ["./entrypoint.sh"]
