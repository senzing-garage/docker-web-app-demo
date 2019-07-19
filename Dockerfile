ARG BASE_IMAGE=senzing/senzing-base:1.0.3
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2019-06-21

LABEL Name="senzing/web-app-demo" \
      Maintainer="support@senzing.com" \
      Version="1.0.0"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Install packages via apt.
# Note: There is a work-around for a lsb_release problem in the following RUN command.

RUN apt-get update \
 && apt-get -y install \
      apt-transport-https \
      apt-utils \
      curl \
      default-jdk \
      supervisor \
 && apt-get -y install --reinstall lsb-release \
 && ln -s /usr/share/pyshared/lsb_release.py /usr/local/lib/python3.7/site-packages/lsb_release.py \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get -y install \
      build-essential \
      nodejs \
 && rm -rf /var/lib/apt/lists/*

# Copy files from other docker images.

COPY --from=senzing/senzing-api-server:1.6.1     "/app/senzing-api-server.jar" "/app/senzing-api-server.jar"
COPY --from=senzing/entity-search-web-app:1.0.0  "/app/" "/app/"

# Copy files from repository.

COPY ./rootfs /

# Install NPM program.

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
CMD ["/usr/bin/supervisord --nodaemon"]
