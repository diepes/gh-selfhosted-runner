# Container image of GitHub runner

* Github src - https://github.com/actions/runner/releases

This builds a container that contains the Github runner that can be deployed in a k8s(kubernetes) cluster and then targeted by Github actions to runs task on selfhosted runner (this container)

## config.env - vars

 1. template config.template.env
 1. Update DOCKER_REPO for upload
    * e.g. DOCKER_REPO="myrepo.azurecr.io"
           DOCKER_NAME="latest"
 1. Set labels to target from Github actions
    * e.g. GH_LABELS="my_testrunner,my_test1"

## Usage

 1. cp config.template.env to config.env and update values
 1. update config.env, see above.
 1. build container ./go-build will have tags set in config.env
 1. upload container to container registry
    * e.g. [Azure](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli) $ az acr login --name myregistry
    * $ docker push ${DOCKER_REPO}/${DOCKER_NAME}

## Local test
 1. Generate Github -> Actions -> SelfHosted Runner -> New Runner -> get token
 2. ./go-run_local.sh
    1. Might have to authenticate to docker container registry
       * e.g. Azure acr $ az acr login -n <acrName>

## k8s deployment

* ToDo ...
* GH_TOKEN
