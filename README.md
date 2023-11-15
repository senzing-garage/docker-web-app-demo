# docker-web-app-demo

## Synopsis

The [senzing/web-app-demo](https://hub.docker.com/r/senzing/web-app-demo)
docker image is a "convenience" docker image
which demonstrates the combination of two projects:

1. [senzing-poc-server](https://github.com/Senzing/senzing-poc-server)
1. [entity-search-web-app](https://github.com/Senzing/entity-search-web-app)

It is called a "convenience docker image" because it doesn't follow all of the best practices
for Docker image construction, but is easy to use in demonstrations.

## Overview

1. It's as simple as setting `SENZING_ENGINE_CONFIGURATION_JSON`, running...

    ```console
    docker run \
      --env SENZING_ENGINE_CONFIGURATION_JSON \
      --publish 8250:8250 \
      --publish 8251:8251 \
      senzing/web-app-demo
    ```

1. ...and viewing Senzing Entity Search WebApp at
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
1. [License](#license)
1. [References](#references)

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
   [Backing Services](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/deploy-rabbitmq-postgresql-backing-services.md#using-docker-compose).

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

## References

- [Development](docs/development.md)
- [Errors](docs/errors.md)
- [Examples](docs/examples.md)
- Related artifacts
  - [DockerHub](https://hub.docker.com/r/senzing/web-app-demo)
- [Verify container](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/verify-container.md)
