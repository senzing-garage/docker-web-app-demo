# docker-web-app-demo

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage] where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Synopsis

The [senzing/web-app-demo] docker image is a "convenience" docker image
which demonstrates the combination of two projects:

1. [senzing-poc-server]
1. [entity-search-web-app]

It is called a "convenience docker image" because it doesn't follow all of the best practices
for Docker image construction, but is easy to use in demonstrations.

## Overview

1. First, set your environment variables:

   ```
   export SENZING_ENGINE_CONFIGURATION_JSON='{
      "PIPELINE": {
            "LICENSESTRINGBASE64": "",
            "SUPPORTPATH": "/opt/senzing/data",
            "RESOURCEPATH": "/opt/senzing/g2/resources",
            "CONFIGPATH": "/etc/opt/senzing"
      },
      "SQL": {
            "CONNECTION": "postgresql://postgres:postgres@senzing-postgres:5432:G2/"
      }
   }'

   export SENZING_DATA_MART_POSTGRESQL_HOST="senzing-postgres"
   export SENZING_DATA_MART_POSTGRESQL_PORT="5432"
   export SENZING_DATA_MART_POSTGRESQL_DATABASE="G2"
   export SENZING_DATA_MART_POSTGRESQL_USER="postgres"
   export SENZING_DATA_MART_POSTGRESQL_PASSWORD="postgres"
   ```

1. Then run the docker image using:

   ```console
   docker run \
      --env SENZING_ENGINE_CONFIGURATION_JSON \
      --env SENZING_DATA_MART_POSTGRESQL_HOST \
      --env SENZING_DATA_MART_POSTGRESQL_PORT \
      --env SENZING_DATA_MART_POSTGRESQL_DATABASE \
      --env SENZING_DATA_MART_POSTGRESQL_USER \
      --env SENZING_DATA_MART_POSTGRESQL_PASSWORD \
      --publish 8250:8250 \
      --publish 8251:8251 \
      --rm \
      senzing/web-app-demo
   ```

1. Once the docker image is running, you can view the Senzing Entity Search WebApp at
   [localhost:8251].

1. See
   [Demonstrate using Docker]
   for more details.

### Contents

1. [Demonstrate using Docker]
   1. [Pre-requisites]
   1. [Set environment variables]
   1. [Run Docker container]
1. [Demonstrate using docker-compose]
1. [View services]
   1. [View Senzing Entity Search WebApp]
   1. [View Senzing API Server]
1. [License]
1. [References]

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
  - [Docker]
  - [Docker-compose]

## Demonstrate using Docker

### Pre-requisites

1. A database that has been populated with the Senzing schema and Senzing configuration.
   For an example, visit
   [Backing Services]

1. A database for the data mart. This may be unpopulated and if so, the schema will be laid down.
   It may _also_ be the same database used for the Senzing schema and Senzing configuration,
   though performance may degrade if using SQLite.

### Set environment variables

1. Construct the `SENZING_ENGINE_CONFIGURATION_JSON` environment variable.

   **Note:** All JSON values must relative to _inside_ the Docker container.
   For instance, the database hostname specified in `SQL`.`CONNECTION`
   cannot be `localhost` nor `127.0.0.1`.
   The paths are relative to the Senzing installation _inside_ the container,
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

1. Set the Data Mart environment variables to the data mart repository can be found.
   **NOTE**: When using any database other than SQLite, you may use the same database as with the `SENZING_ENGINE_CONFIGURATION_JSON` environment variable.

   Example:

   ```console
   export SENZING_DATA_MART_POSTGRESQL_HOST="senzing-postgres"
   export SENZING_DATA_MART_POSTGRESQL_PORT="5432"
   export SENZING_DATA_MART_POSTGRESQL_DATABASE="G2"
   export SENZING_DATA_MART_POSTGRESQL_USER="postgres"
   export SENZING_DATA_MART_POSTGRESQL_PASSWORD="postgres"
   ```

### Run Docker container

1. Run Docker container.
   Example:

   ```console
   docker run \
     --env SENZING_ENGINE_CONFIGURATION_JSON \
     --env SENZING_DATA_MART_POSTGRESQL_HOST \
     --env SENZING_DATA_MART_POSTGRESQL_PORT \
     --env SENZING_DATA_MART_POSTGRESQL_DATABASE \
     --env SENZING_DATA_MART_POSTGRESQL_USER \
     --env SENZING_DATA_MART_POSTGRESQL_PASSWORD \
     --publish 8250:8250 \
     --publish 8251:8251 \
     --rm \
     senzing/web-app-demo
   ```

1. [View services].

## Demonstrate using docker-compose

1. Deploy the
   [Backing Services].

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

1. Senzing Entity Search WebApp is viewable at [localhost:8251].
1. See [entity-search-web-app] for more details.

### View Senzing API Server

View results from Senzing REST API server.
The server supports the [Senzing REST API].

1. Example Senzing REST API request: [localhost:8250/heartbeat]
1. To try the Senzing REST API, open the [OpenApi Editor]
   1. Set **Servers** value to [http://localhost:8250]
1. See [senzing-api-server] for more details.

## License

View [license information] for the software container in this Docker image.
Note that this license does not permit further distribution.

This Docker image may also contain software from the
[Senzing GitHub community] under the [Apache License 2.0].

Further, as with all Docker images,
this likely also contains other software which may be under other licenses
(such as Bash, etc. from the base distribution,
along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage,
it is the image user's responsibility to ensure that any use of this image complies
with any relevant licenses for all software contained within.

## References

- [Development]
- [Errors]
- [Examples]
- Related artifacts
  - [DockerHub]
- [Verify container]

[Apache License 2.0]: https://www.apache.org/licenses/LICENSE-2.0
[Backing Services]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/deploy-rabbitmq-postgresql-backing-services.md#using-docker-compose
[Demonstrate using docker-compose]: #demonstrate-using-docker-compose
[Demonstrate using Docker]: #demonstrate-using-docker
[Development]: docs/development.md
[Docker-compose]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker-compose.md
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[DockerHub]: https://hub.docker.com/r/senzing/web-app-demo
[entity-search-web-app]: https://github.com/senzing-garage/entity-search-web-app
[Errors]: docs/errors.md
[Examples]: docs/examples.md
[http://localhost:8250]: http://localhost:8250
[license information]: https://senzing.com/end-user-license-agreement/
[License]: #license
[localhost:8250/heartbeat]: http://localhost:8250/heartbeat
[localhost:8251]: http://localhost:8251
[OpenApi Editor]: https://petstore.swagger.io/?url=https://raw.githubusercontent.com/Senzing/senzing-rest-api-specification/main/senzing-rest-api.yaml
[Pre-requisites]: #pre-requisites
[References]: #references
[Run Docker container]: #run-docker-container
[Senzing Garage]: https://github.com/senzing-garage
[Senzing GitHub community]: https://github.com/Senzing/
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[Senzing REST API]: https://github.com/Senzing/senzing-rest-api-specification
[senzing-api-server]: https://github.com/Senzing/senzing-api-server
[senzing-poc-server]: https://github.com/senzing-garage/senzing-poc-server
[Senzing]: https://senzing.com/
[senzing/web-app-demo]: https://hub.docker.com/r/senzing/web-app-demo
[Set environment variables]: #set-environment-variables
[Verify container]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/verify-container.md
[View Senzing API Server]: #view-senzing-api-server
[View Senzing Entity Search WebApp]: #view-senzing-entity-search-webapp
[View services]: #view-services
