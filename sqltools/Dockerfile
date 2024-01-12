FROM lscr.io/linuxserver/doublecommander:latest

# set version label
ARG DEBIAN_FRONTEND="noninteractive"


RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    gnome-terminal \
    kate \
    mysql-client \
    libzip4 && \
    curl -L -o dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb && \
    dpkg -i dbeaver.deb && \
    rm dbeaver.deb && \
    apt-get clean && \
    rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# ports and volumes
EXPOSE 3000
VOLUME /config
VOLUME /data

COPY /root /



