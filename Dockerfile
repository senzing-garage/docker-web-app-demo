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
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get -y install \
      build-essential \
      nodejs \
 && rm -rf /var/lib/apt/lists/*

# Service exposed on port 8080.

EXPOSE 8080

# Copy files from other docker images.

COPY --from=senzing/senzing-api-server "/app/senzing-api-server.jar" "/app/senzing-api-server.jar"
COPY --from=senzing/sdk-components-example-web-app "/app/" "/app/"

# Install NPM program

WORKDIR /app

RUN npm init -y \
 && npm install

# Runtime execution.

WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh", "java -jar senzing-api-server.jar" ]
CMD [""]
