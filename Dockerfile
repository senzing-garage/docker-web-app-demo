ARG BASE_IMAGE=senzing/senzing-base:1.6.8
FROM ${BASE_IMAGE}

ENV REFRESHED_AT=2022-05-10

LABEL Name="senzing/web-app-demo" \
      Maintainer="support@senzing.com" \
      Version="2.1.4"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages via apt.
# Note: There is a work-around for a lsb_release problem in the following RUN command.

RUN apt-get update \
 && apt-get -y install \
      apt-transport-https \
      apt-utils \
      curl \
      default-jdk \
      fio \
      htop \
      iotop \
      ipython3 \
      itop \
      less \
      net-tools \
      odbc-postgresql \
      procps \
      supervisor \
      tree \
      unixodbc \
      unixodbc-dev \
      vim \
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get -y install \
      build-essential \
      nodejs \
 && rm -rf /var/lib/apt/lists/*

# Install packages via pip.

RUN pip3 install --upgrade pip \
 && pip3 install \
      csvkit \
      fuzzywuzzy \
      ptable \
      pandas \
      python-levenshtein \
      pyodbc \
      setuptools

# Copy files from other docker images.

COPY --from=senzing/senzing-poc-server:3.0.1     "/app/senzing-poc-server.jar" "/app/senzing-poc-server.jar"
COPY --from=senzing/entity-search-web-app:2.6.0  "/app/" "/app/"

# Copy files from repository.

COPY ./rootfs /

# Install NPM program.

WORKDIR /app
RUN npm install

# Services exposed on port 8250 and 8251.

EXPOSE 8250
EXPOSE 8251

# Temporary work around until the following is resolved:
# https://github.com/Senzing/entity-search-web-app/issues/107

RUN touch /app/proxy.conf.json \
 && chmod 777 /app/proxy.conf.json

# Make non-root container.

# USER 1001

# Runtime execution.

ENV SENZING_API_SERVER_ENABLE_ADMIN=true
ENV SENZING_API_SERVER_URL="http://localhost:8250"
ENV SENZING_WEB_SERVER_ADMIN_AUTH_MODE=NONE
ENV SENZING_WEB_SERVER_PORT=8251
ENV SENZING_WEB_SERVER_URL="http://localhost:8251"

WORKDIR /app
CMD ["/usr/bin/supervisord", "--nodaemon"]
