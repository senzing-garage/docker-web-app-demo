# docker-web-app-demo

## Synopsis

This repository is used to create a "convenience" `senzing/web-app-demo` docker image
which demonstrates the combination of two projects:

1. [senzing-poc-server](https://github.com/Senzing/senzing-poc-server)
1. [entity-search-web-app](https://github.com/Senzing/entity-search-web-app)

It is called a "convenience docker image" because it doesn't follow all of the best practices
for Docker image construction, but is easy to use.

## Overview

1. It's as simple as...

    ```console
    docker run \
      --env-file senzing.env \
      --publish 8250:8250 \
      --publish 8251:8251 \
      senzing/web-app-demo
    ```

1. ...and view Senzing Entity Search WebApp at
   [localhost:8251](http://localhost:8251).

1. See
   [Demonstrate using Docker](#demonstrate-using-docker)
   for more details.

## Contents

1. [Expectations](#expectations)
1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [Pre-requisites](#pre-requisites)
    1. [Create Docker.env file with Senzing Engine configuration](#create-docker-env-file-with-senzing-engine-configuration)
    1. [Run Docker container](#run-docker-container)
1. [Demonstrate using docker-compose](#demonstrate-using-docker-compose)
1. [View services](#view-services)
    1. [View Senzing Entity Search WebApp](#view-senzing-entity-search-webapp)
    1. [View Senzing API Server](#view-senzing-api-server)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Advanced](#advanced)
    1. [Related artifacts](#related-artifacts)
    1. [Container Signature Verification](#container-signature-verification)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 15 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker.md)
  - [Docker-compose](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker-compose.md)

## Demonstrate using Docker

### Pre-requisites

1. A database that has been populated with the Senzing schema and Senzing configuration.

1. :thinking: Alternatively, a demonstration database can be provisioned
   by following the instructions at
   [Demonstrate using docker-compose](#demonstrate-using-docker-compose)
   using this variation of the `docker-compose up` command:

    ```console
    cd ${SENZING_DEMO_DIR}
    sudo --preserve-env docker-compose up postgres init-postgresql
    ```

### Create Docker .env file with Senzing Engine configuration

1. Construct the `SENZING_ENGINE_CONFIGURATION_JSON` environment variable.

   **Note:** All JSON values must relative to *inside* the Docker container.
   For instance, the database hostname specified in `SQL`.`CONNECTION`
   cannot be `localhost` nor `127.0.0.1`.
   The paths are relative to the Senzing installation *inside* the container,
   not on the system hosting the Docker containers.

   Example:

    ```console
    export SENZING_ENGINE_CONFIGURATION_JSON='
    {
        "PIPELINE": {
            "CONFIGPATH": "/etc/opt/senzing",
            "LICENSESTRINGBASE64": "",
            "RESOURCEPATH": "/opt/senzing/g2/resources",
            "SUPPORTPATH": "/opt/senzing/data"
        },
        "SQL": {
            "CONNECTION": "postgresql://postgres:postgres@senzing-postgres:5432:G2/"
        }
    }
    '
    ```

1. :pencil2: Specify a file to be used as
   [Docker --env-file](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file).
   Example:

   ```console
   export SENZING_DOCKER_ENV_FILE=~/senzing.env
   ```

1. Create the `${SENZING_DOCKER_ENV_FILE}` file.
   Example:

    ```console
    echo "SENZING_ENGINE_CONFIGURATION_JSON=${SENZING_ENGINE_CONFIGURATION_JSON}" \
        | sed -e ':a;N;$!ba;s/\n//g' \
        > ${SENZING_DOCKER_ENV_FILE}
    ```

### Run docker container

1. :thinking: If using docker-compose to bring up a database stack,
   set the `--net` parameter for use in `docker run`.
   Example:

    ```console
    export SENZING_NETWORK_PARAMETER="--net senzing-network"
    ```

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      --env-file ${SENZING_DOCKER_ENV_FILE} \
      --name senzing-web-app-demo \
      --publish 8250:8250 \
      --publish 8251:8251 \
      --rm \
      ${SENZING_NETWORK_PARAMETER} \
      senzing/web-app-demo
    ```

1. [View services](#view-services).

## Demonstrate using docker-compose

The following instructions bring up a docker-compose stack consisting of
a demonstration PostgreSQL database and `senzing/web-app-demo`.
It is meant for quick demonstration purposes,
not for production.

1. :pencil2: Specify where to store demonstration data.
   Example:

    ```console
    export SENZING_DEMO_DIR=~/my-senzing-demo
    ```

1. Set environment variables used in `docker-compose.yaml` file.
   Example:

    ```console
    export POSTGRES_DIR=${SENZING_DEMO_DIR}/postgres
    export SENZING_UID=$(id -u)
    ```

1. Setup demonstration directory.
   Example:

    ```console
    mkdir -p ${POSTGRES_DIR}
    chmod -R 755 ${POSTGRES_DIR}
    ```

1. Set environment variables for Docker image tags used in `docker-compose.yaml` file.
   Example:

    ```console
    curl -X GET \
        --output ${SENZING_DEMO_DIR}/docker-versions-stable.sh \
        https://raw.githubusercontent.com/Senzing/knowledge-base/main/lists/docker-versions-stable.sh
    source ${SENZING_DEMO_DIR}/docker-versions-stable.sh
    ```

1. Download `docker-compose.yaml` and Docker images.
   Example:

    ```console
    curl -X GET \
        --output ${SENZING_DEMO_DIR}/docker-compose.yaml \
        "https://raw.githubusercontent.com/Senzing/docker-web-app-demo/main/docker-compose.yaml"
    cd ${SENZING_DEMO_DIR}
    sudo --preserve-env docker-compose pull
    ```

1. Bring up Senzing docker-compose stack.
   Example:

    ```console
    cd ${SENZING_DEMO_DIR}
    sudo --preserve-env docker-compose up
    ```

## View services

### View Senzing Entity Search WebApp

1. Senzing Entity Search WebApp is viewable at
   [localhost:8251](http://localhost:8251).

### View Senzing API Server

View results from Senzing REST API server.
The server supports the
[Senzing REST API](https://github.com/Senzing/senzing-rest-api-specification).

1. The
   [OpenApi Editor](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/Senzing/senzing-rest-api-specification/main/senzing-rest-api.yaml)
   with **Servers** value of [http://localhost:8250](http://localhost:8250)
   can be used to try the Senzing REST API.
1. Example Senzing REST API request:
   [localhost:8250/heartbeat](http://localhost:8250/heartbeat)

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-web-app-demo
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/clone-repository.md) to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build \
      --tag senzing/web-app-demo \
      https://github.com/senzing/docker-web-app-demo.git#main
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/web-app-demo .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples

## Advanced

### Related artifacts

1. DockerHub
    1. [senzing/web-app-demo](https://hub.docker.com/r/senzing/web-app-demo)

### Container Signature Verification

Container image integrity has become increasingly important as images are being deployed into zero-trust environments. The image integrity is achieved by container signatures. They provide developers with cryptographic assurance that the images they are pulling in are from a trusted source.

To verify Senzing's dockerhub images, first copy the hash of the docker image pulled.
![dockerhub hash](assets/dockerhub_hash.png)

Then verify the hash using cosign.

```console
COSIGN_EXPERIMENTAL=1 cosign verify senzing/web-app-demo@sha256:<insert sha256 hash>
```

This is what a successful verification looks like.
![cosign verify](assets/cosign_verify.png)

To learn more about cosign and how to install, go [here](https://github.com/sigstore/cosign).

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
