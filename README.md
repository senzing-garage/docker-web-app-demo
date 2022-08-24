# docker-web-app-demo

## Overview

This repository is used to create the `senzing/web-app-demo` docker image
which demonstrates the combination of two projects:

1. [senzing-poc-server](https://github.com/Senzing/senzing-poc-server)
1. [entity-search-web-app](https://github.com/Senzing/entity-search-web-app)

### Related artifacts

1. DockerHub
    1. [senzing/web-app-demo](https://hub.docker.com/r/senzing/web-app-demo)
    1. [senzing/web-app-demo-unstable](https://hub.docker.com/r/senzing/web-app-demo-unstable)

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate using Docker](#demonstrate-using-docker)
1. [Demonstrate using docker-compose](#demonstrate-using-docker-compose)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Advanced](#advanced)
    1. [Configuration](#configuration)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 15 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker.md)

## Demonstrate using Docker

### Pre-requisites

1. A database that has been populated with the Senzing schema and Senzing configuration.

### Steps

1. :pencil2: Specify a file that will contain the Senzing Engine Configuration JSON.
   Example:

    ```console
    export SENZING_ENGINE_CONFIGURATION_JSON_FILE=~/senzing-engine-configuration.json
    ```

1. Create `${SENZING_ENGINE_CONFIGURATION_JSON_FILE}`
   containing Senzing Engine Configuration JSON.
   **Note:** All JSON values must relative to *inside* the Docker container.
   For instance, the database hostname specified in `SQL`.`CONNECTION`
   cannot be `localhost` nor `127.0.0.1`.
   The paths are relative to the Senzing installation *inside* the container,
   not on the system hosting the Docker containers.
   Example `${SENZING_ENGINE_CONFIGURATION_JSON_FILE}` contents:

    ```json
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
    ```

### Run docker container

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      --env SENZING_ENGINE_CONFIGURATION_JSON=$(cat ${SENZING_ENGINE_CONFIGURATION_JSON_FILE}) \
      --name senzing-web-app-demo \
      --publish 8250:8250 \
      --publish 8251:8251 \
      --rm \
      senzing/web-app-demo
    ```

## Demonstrate using docker-compose

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
    sudo --preserve-env docker-compose --profile all pull
    ```

1. Bring up Senzing docker-compose stack.
   Example:

    ```console
    cd ${SENZING_DEMO_DIR}
    sudo --preserve-env docker-compose --profile all up
    ```

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

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[SENZING_DATA_VERSION_DIR](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_data_version_dir)**
- **[SENZING_DATABASE_URL](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_database_url)**
- **[SENZING_DEBUG](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_debug)**
- **[SENZING_ETC_DIR](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_etc_dir)**
- **[SENZING_G2_DIR](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_g2_dir)**
- **[SENZING_NETWORK](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_network)**
- **[SENZING_RUNAS_USER](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_runas_user)**
- **[SENZING_VAR_DIR](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#senzing_var_dir)**

## Errors

1. See [docs/errors.md](docs/errors.md).

## References
