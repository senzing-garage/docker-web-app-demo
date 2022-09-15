# docker-web-app-demo

## Synopsis

The [senzing/python-demo](https://hub.docker.com/r/senzing/python-demo)
docker image is a "convenience" docker image
which demonstrates the combination of two projects:

1. [senzing-poc-server](https://github.com/Senzing/senzing-poc-server)
1. [entity-search-web-app](https://github.com/Senzing/entity-search-web-app)

It is called a "convenience docker image" because it doesn't follow all of the best practices
for Docker image construction, but is easy to use in demonstrations.

## Overview

1. It's as simple as...

    ```console
    docker run \
      --env SENZING_ENGINE_CONFIGURATION_JSON \
      --publish 8250:8250 \
      --publish 8251:8251 \
      senzing/web-app-demo
    ```

1. ...and view Senzing Entity Search WebApp at
   [localhost:8251](http://localhost:8251).

1. See
   [Demonstrate using Docker](#demonstrate-using-docker)
   for more details.

### Contents

1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [Pre-requisites](#pre-requisites)
    1. [Set environment variables](#set-environment-variables)
    1. [Run Docker container](#run-docker-container)
1. [Demonstrate using docker-compose](#demonstrate-using-docker-compose)
1. [View services](#view-services)
    1. [View Senzing Entity Search WebApp](#view-senzing-entity-search-webapp)
    1. [View Senzing API Server](#view-senzing-api-server)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build Docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Advanced](#advanced)
    1. [Related artifacts](#related-artifacts)
    1. [Container Signature Verification](#container-signature-verification)
1. [Errors](#errors)
1. [References](#references)
1. [License](#license)

### Preamble

At [Senzing](http://senzing.com),
we strive to create GitHub documentation in a
"[don't make me think](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/dont-make-me-think.md)" style.
For the most part, instructions are copy and paste.
Whenever thinking is needed, it's marked with a "thinking" icon :thinking:.
Whenever customization is needed, it's marked with a "pencil" icon :pencil2:.
If the instructions are not clear, please let us know by opening a new
[Documentation issue](https://github.com/Senzing/template-python/issues/new?template=documentation_request.md)
describing where we can improve.   Now on with the show...

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps there are some choices to be made.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

### Expectations

- **Space:** This repository and demonstration require 6 GB free disk space.
- **Time:** Budget 15 minutes to get the demonstration up-and-running, depending on CPU and network speeds.
- **Background knowledge:** This repository assumes a working knowledge of:
  - [Docker](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker.md)
  - [Docker-compose](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker-compose.md)

## Demonstrate using Docker

### Pre-requisites

1. A database that has been populated with the Senzing schema and Senzing configuration.
   For an example, visit
   [Backing Services](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/deploy-rabbitmq-postgresql-backing-services.md#using-docker-compose)

### Set environment variables

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

### Run Docker container

1. Run Docker container.
   Example:

    ```console
    docker run \
      --env SENZING_ENGINE_CONFIGURATION_JSON \
      --publish 8250:8250 \
      --publish 8251:8251 \
      --rm \
      senzing/web-app-demo
    ```

1. [View services](#view-services).

## Demonstrate using docker-compose

1. Deploy the
   [Backing Services](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/deploy-rabbitmq-postgresql-backing-services.md#using-docker-compose)
   required by the Stream Loader.

1. Specify a directory to place artifacts in.
   Example:

    ```console
    export SENZING_VOLUME=~/my-senzing
    mkdir -p ${SENZING_VOLUME}

    ```

1. Download `docker-compose.yaml` file.
   Example:

    ```console
    curl -X GET \
      --output ${SENZING_VOLUME}/docker-compose.yaml \
      https://raw.githubusercontent.com/Senzing/docker-web-app-demo/main/docker-compose.yaml

    ```

1. Bring up docker-compose stack.
   Example:

    ```console
    docker-compose -f ${SENZING_VOLUME}/docker-compose.yaml up

    ```

## View services

### View Senzing Entity Search WebApp

1. Senzing Entity Search WebApp is viewable at
   [localhost:8251](http://localhost:8251).
1. See
   [entity-search-web-app](https://github.com/Senzing/entity-search-web-app)
   for more details.

### View Senzing API Server

View results from Senzing REST API server.
The server supports the
[Senzing REST API](https://github.com/Senzing/senzing-rest-api-specification).

1. Example Senzing REST API request:
   [localhost:8250/heartbeat](http://localhost:8250/heartbeat)
1. To try the Senzing REST API, open the
   [OpenApi Editor](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/Senzing/senzing-rest-api-specification/main/senzing-rest-api.yaml)
    1. Set **Servers** value to [http://localhost:8250](http://localhost:8250)
1. See
   [senzing-api-server](https://github.com/Senzing/senzing-api-server)
   for more details.

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

### Build Docker image for development

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

    Note: `sudo make docker-build-development-cache` can be used to create cached Docker layers.

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

## License

View
[license information](https://senzing.com/end-user-license-agreement/)
for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the
[Senzing GitHub community](https://github.com/Senzing/)
under the
[Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

Further, as with all Docker images,
this likely also contains other software which may be under other licenses
(such as Bash, etc. from the base distribution,
along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage,
it is the image user's responsibility to ensure that any use of this image complies
with any relevant licenses for all software contained within.
