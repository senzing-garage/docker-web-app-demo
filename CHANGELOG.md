# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
[markdownlint](https://dlaa.me/markdownlint/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
