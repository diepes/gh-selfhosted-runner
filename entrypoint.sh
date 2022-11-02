#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN
GH_LABELS=$GH_LABELS

echo "Debug GH_OWNER=${GH_OWNER} GH_REPOSITORY=${GH_REPOSITORY} GH_LABELS=${GH_LABELS}"

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME="dockerNode-${RUNNER_SUFFIX}"

# REG_CURL=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token )
# echo "Debug REG_CURL=$REG_CURL"
# REG_TOKEN=echo "$REG_CURL" | jq .token --raw-output)
# echo "Debug REG_TOKEN=$REG_TOKEN "

cd /home/docker/actions-runner

./config.sh --unattended --url https://github.com/${GH_OWNER}/${GH_REPOSITORY} --token ${GH_TOKEN} --name ${RUNNER_NAME} --labels "${GH_LABELS}"

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
