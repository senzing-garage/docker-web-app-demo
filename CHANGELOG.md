# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.4] - 2022-05-10

### Changed to 2.1.4

- Upgrade to `senzing/senzing-api-server:3.0.1`
- Upgrade to `senzing/entity-search-web-app:2.6.0`

## [2.1.3] - 2021-10-11

### Changed to 2.1.3

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
- Update to https://deb.nodesource.com/setup_12.x

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
  - [senzing/senzing-base:1.2.1](https://github.com/Senzing/docker-senzing-base/tree/1.2.1)
  - [senzing/senzing-api-server:1.7.2](https://github.com/Senzing/senzing-api-server/tree/1.7.2)
  - [senzing/entity-search-web-app:1.0.2](https://github.com/Senzing/entity-search-web-app/tree/1.0.2)

## [1.0.0] - 2019-06-21

### Added to 1.0.0

- Dockerfile combining:
  - [senzing-api-server 1.6.1](https://github.com/Senzing/senzing-api-server/tree/1.6.1)
  - [entity-search-web-app 1.0.0](https://github.com/Senzing/entity-search-web-app/tree/1.0.0)
- Uses [supervisord](http://supervisord.org/) to manage multiple processes.
