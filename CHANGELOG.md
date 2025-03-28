# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.5.0] - 2024-12-12

### Changed in 2.5.0

- In `Dockerfile`
  - Upgrade to `senzing/senzing-pog-server:3.6.4`
  - Upgrade to `senzing/entity-search-web-app:3.0.0`
- In `docker-compose.yaml`
  - Add environment variables for datamart:
    - `SENZING_DATA_MART_POSTGRESQL_HOST`
    - `SENZING_DATA_MART_POSTGRESQL_PORT`
    - `SENZING_DATA_MART_POSTGRESQL_DATABASE`
    - `SENZING_DATA_MART_POSTGRESQL_USER`
    - `SENZING_DATA_MART_POSTGRESQL_PASSWORD`
- Update `README.md` with instructions for initializing data mart

## [2.4.20] - 2024-06-24

### Changed in 2.4.20

- In `Dockerfile`
  - Upgrade to `senzing/senzingapi-runtime:3.10.3`

## [2.4.19] - 2024-05-22

### Changed in 2.4.19

- In `Dockerfile`
  - Upgrade to `senzing/senzingapi-runtime:3.10.1`

## [2.4.18] - 2024-05-22

### Changed in 2.4.18

- In `Dockerfile`
  - Downgrade to `senzing/senzing-poc-server:3.4.8` due to compatibility issue.

## [2.4.17] - 2024-03-21

### Changed in 2.4.17

- In `Dockerfile`
  - Upgrade to `senzing/senzing-poc-server:3.5.4`

## [2.4.16] - 2024-03-21

### Changed in 2.4.16

- In `Dockerfile`
  - Upgrade to `senzing/senzing-poc-server:3.5.3`

## [2.4.15] - 2024-03-18

### Changed in 2.4.15

- In `Dockerfile`
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.9.0`
  - Upgrade to `senzing/senzing-poc-server:3.5.2`

## [2.4.14] - 2024-02-02

### Changed in 2.4.14

- In `Dockerfile`
  - Upgrade to `senzing/senzing-poc-server:3.5.1`

## [2.4.13] - 2023-11-14

### Changed in 2.4.13

- In `Dockerfile`
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.8.0`
  - Upgrade to `senzing/senzing-poc-server:3.4.8`

## [2.4.12] - 2023-09-29

### Changed in 2.4.12

- In `Dockerfile`
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.7.1`
  - Upgrade to `senzing/senzing-poc-server:3.4.7`
  - Upgrade to `senzing/entity-search-web-app:2.9.1`

## [2.4.11] - 2023-06-29

### Changed in 2.4.11

- In `Dockerfile`
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.6.0`
  - Upgrade to `senzing/senzing-poc-server:3.4.4`
  - Upgrade to `senzing/entity-search-web-app:2.8.2`

## [2.4.10] - 2023-06-15

### Changed in 2.4.10

- In `Dockerfile`
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.5.3`
  - Upgrade to `senzing/senzing-poc-server:3.4.3`

## [2.4.9] - 2023-05-11

### Changed in 2.4.9

- In `Dockerfile`:
  - Upgrade to `senzing/entity-search-web-app:2.8.1`

## [2.4.8] - 2023-05-10

### Changed in 2.4.8

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.5.2`
  - Upgrade to `senzing/senzing-poc-server:3.4.1`

## [2.4.7] - 2023-04-04

### Changed in 2.4.7

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.5.0`
  - Upgrade to `senzing/senzing-poc-server:3.3.9`
  - Upgrade to `senzing/entity-search-web-app:2.8.0`

## [2.4.6] - 2023-01-12

### Changed in 2.4.6

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.4.0`
  - Upgrade to `senzing/senzing-poc-server:3.3.5`
  - Upgrade to `senzing/entity-search-web-app:2.7.4`

## [2.4.5] - 2022-10-27

### Changed in 2.4.5

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.3.2`
  - Upgrade to `senzing/senzing-poc-server:3.3.3`
  - Upgrade to `senzing/entity-search-web-app:2.7.3`

## [2.4.4] - 2022-10-11

### Changed in 2.4.4

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.3.1`
  - Upgrade to `senzing/senzing-poc-server:3.3.2`
  - Upgrade to `senzing/entity-search-web-app:2.7.2`

## [2.4.3] - 2022-09-28

### Changed in 2.4.3

- In `Dockerfile`:
  - Updated FROM instruction to `senzing/senzingapi-runtime:3.3.0`
  - Upgrade to `senzing/senzing-poc-server:3.3.1`
  - Upgrade to `senzing/entity-search-web-app:2.7.2`

## [2.4.2] - 2022-09-15

- Upgrade to `senzing/senzing-poc-server:3.2.3`

### Changed in 2.4.2

## [2.4.1] - 2022-08-25

### Changed in 2.4.1

- In `Dockerfile`, bump from `senzing/senzingapi-runtime:3.1.2` to `senzing/senzingapi-runtime:3.2.0`

## [2.4.0] - 2022-08-25

### Changed to 2.4.0

- Upgrade to `senzing/senzing-poc-server:3.2.1`
- Upgrade to `senzing/entity-search-web-app:2.7.1`
- Removed extraneous apt-get packages
- Removed all pip installs
- Migrated from  senzing-base:1.6.10 to senzingapi-runtime:3.1.2
- Moved Senzing API Server options from `supervisord` config file to environment variables
- Updated README.md

### Deleted in 2.4.0

- `Dockerfile-unstable`

## [2.3.0] - 2022-07-08

### Changed to 2.3.0

- Upgrade to `senzing/senzing-poc-server:3.0.2`
- Upgrade to `senzing/entity-search-web-app:2.7.0`

## [2.2.0] - 2022-05-19

### Changed to 2.2.0

- Supports Senzing V3
- Switched to `senzing/senzing-poc-server:3.0.1`
- Upgrade to `senzing/entity-search-web-app:2.6.0`

## [2.1.3] - 2021-10-11

### Changed to 2.1.3

- Last version supporting Senzing V2
- Upgrade to `senzing/senzing-base:1.6.2`
- Upgrade to `senzing/senzing-api-server:2.7.4`
- Upgrade to `senzing/entity-search-web-app:2.3.2`

## [2.1.2] - 2021-08-05

### Added to 2.1.2

- Upgrade to senzing/senzing-base:1.6.1

## [2.1.1] - 2021-02-03

### Added in 2.1.1

- Packages: `procps`, `tree`

### Changed in 2.1.1

- Updated base to `senzing/senzing-base:1.5.2`
- Updated to `senzing/senzing-api-server:2.3.1`
- Updated to `senzing/entity-search-web-app:2.2.1`

## [2.1.0] - 2020-10-28

### Changed in 2.1.0

- Update to `senzing-api-server:2.2.1`, `entity-search-web-app:2.1.1`
- Update to <https://deb.nodesource.com/setup_12.x>

### Fixed in 2.1.0

- Fixed environment variables

## [2.0.0] - 2020-07-17

### Changed in 2.0.0

- Works with senzing versions 2.0.0 and above
- Update to senzing/senzing-api-server:2.0.0
- Update to senzing/entity-search-web-app:2.0.0
- Added environment variables:
  - `SENZING_WEB_SERVER_ADMIN_AUTH_MODE`
  - `SENZING_WEB_SERVER_ADMIN_AUTH_PATH`
  - `SENZING_WEB_SERVER_URL`

## [1.3.0] - 2020-07-08

### Changed in 1.3.0

- Works with senzing versions up to 1.15.6
- Not supported for senzing version 2.0.0 and above
- Update to senzing/senzing-base:1.5.1

## [1.2.3] - 2020-06-11

### Fixed in 1.2.3

- Fixed CORS issue for Senzing API server

## [1.2.2] - 2020-05-13

### Changed in 1.2.2

- Work-around for /app/proxy.conf.json
- Change port from 80 to 8251

## [1.2.1] - 2020-05-05

### Changed in 1.2.1

- Update to senzing/senzing-api-server:1.8.3

## [1.2.0] - 2020-01-31

### Changed in 1.2.0

- Update to senzing/senzing-base:1.4.0

## [1.1.1] - 2019-11-18

### Added in 1.1.1

- Add support for MSSQL database.
- Update to senzing/senzing-base:1.3.0

## [1.1.0] - 2019-08-20

### Added to 1.1.0

- Now a non-root, immutable container.
- RPM based installation.

### Changed in 1.1.0

- senzing/web-app-demo:1.1.0 pinned to:
  - [senzing/senzing-base:1.2.1](https://github.com/senzing-garage/docker-senzing-base/tree/1.2.1)
  - [senzing/senzing-api-server:1.7.2](https://github.com/Senzing/senzing-api-server/tree/1.7.2)
  - [senzing/entity-search-web-app:1.0.2](https://github.com/Senzing/entity-search-web-app/tree/1.0.2)

## [1.0.0] - 2019-06-21

### Added to 1.0.0

- Dockerfile combining:
  - [senzing-api-server 1.6.1](https://github.com/Senzing/senzing-api-server/tree/1.6.1)
  - [entity-search-web-app 1.0.0](https://github.com/Senzing/entity-search-web-app/tree/1.0.0)
- Uses [supervisord](http://supervisord.org/) to manage multiple processes.
