ARG BASE_IMAGE=senzing/senzing-base
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-05-01

LABEL Name="senzing/web-app-demo" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt.

RUN apt-get update \
 && apt-get -y install \
      apt-utils \
      curl \
      default-jdk \
      supervisor \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get -y install \
      build-essential \
      nodejs \
 && rm -rf /var/lib/apt/lists/*

 RUN mkdir -p /var/log/supervisor

# Copy files from other docker images.

COPY --from=senzing/senzing-api-server:1.6.1     "/app/senzing-api-server.jar" "/app/senzing-api-server.jar"
COPY --from=senzing/entity-search-web-app:1.0.0  "/app/" "/app/"
COPY ./rootfs /

# Install NPM program

WORKDIR /app

RUN npm init -y \
 && npm install

# Service exposed on port 80.

EXPOSE 80

# Runtime execution.

ENV SENZING_API_SERVER_URL="http://localhost:8090"
ENV SENZING_WEB_SERVER_PORT=80
ENV SENZING_WEB_SERVER_API_PATH="/api"

WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
