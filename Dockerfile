ARG BASE_IMAGE=senzing/senzingapi-runtime:3.3.1
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-10-11

LABEL Name="senzing/web-app-demo" \
      Maintainer="support@senzing.com" \
      Version="2.4.4"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt-get.

RUN apt-get update \
 && apt-get -y install \
      default-jdk \
      supervisor \
      wget \
 && wget -qO - https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get -y install \
      nodejs \
 && rm -rf /var/lib/apt/lists/*

# Copy files from other docker images.

COPY --from=senzing/senzing-poc-server:3.3.2     "/app/senzing-poc-server.jar" "/app/senzing-poc-server.jar"
COPY --from=senzing/entity-search-web-app:2.7.2  "/app/" "/app/"

# Copy files from repository.

COPY ./rootfs /

# Install NPM program.

WORKDIR /app
RUN npm install

# Services exposed on port 8250 and 8251.

EXPOSE 8250
EXPOSE 8251

# Make non-root container.

USER 1001

# Runtime execution.

ENV SENZING_API_SERVER_ALLOWED_ORIGINS="*" \
    SENZING_API_SERVER_BIND_ADDR=all \
    SENZING_API_SERVER_CONCURRENCY=8 \
    SENZING_API_SERVER_ENABLE_ADMIN=true \
    SENZING_API_SERVER_PORT=8250 \
    SENZING_API_SERVER_URL="http://localhost:8250" \
    SENZING_WEB_SERVER_ADMIN_AUTH_MODE=NONE \
    SENZING_WEB_SERVER_PORT=8251 \
    SENZING_WEB_SERVER_URL="http://localhost:8251"

WORKDIR /app
CMD ["/usr/bin/supervisord", "--nodaemon"]
