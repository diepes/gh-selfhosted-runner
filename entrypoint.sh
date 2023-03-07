#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN
GH_LABELS=$GH_LABELS

echo "Debug GH_OWNER=${GH_OWNER} GH_REPOSITORY=${GH_REPOSITORY} GH_LABELS=${GH_LABELS}"

if [[ ${GH_RUNNER_NAME} == "" ]]; then
    RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
    RUNNER_NAME="dockerNode-${RUNNER_SUFFIX}"
else
    RUNNER_NAME=${GH_RUNNER_NAME}
fi

## https://docs.github.com/en/rest/actions/self-hosted-runners?apiVersion=2022-11-28#create-a-registration-token-for-an-organization
# REG_CURL=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token )
# echo "Debug REG_CURL=$REG_CURL"
# REG_TOKEN=echo "$REG_CURL" | jq .token --raw-output)
# echo "Debug REG_TOKEN=$REG_TOKEN "

cd /home/docker/actions-runner

if [[ ! $GH_REPOSITORY == "" ]]; then
    GH_REPOSITORY="/${GH_REPOSITORY}"
fi
./config.sh --unattended --url https://github.com/${GH_OWNER}${GH_REPOSITORY} --token ${GH_TOKEN} --name ${RUNNER_NAME} --labels "${GH_LABELS}"

cleanup() {
    echo "Removing runner..."
    [[ ${GH_REMOVE} == "" ]] && ./config.sh remove --token ${GH_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
