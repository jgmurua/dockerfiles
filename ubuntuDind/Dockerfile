# Usa la imagen base con soporte multiarch
FROM --platform=$BUILDPLATFORM ubuntu:22.10
USER root

# Instala los paquetes necesarios
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-utils \
    dnsutils \
    wget \
    git \
    zip \
    unzip \
    iputils-ping \
    jq \
    software-properties-common \
    sudo

# Instala Docker y Buildx
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    mkdir -p /root/.docker/cli-plugins && \
    wget -qO- https://github.com/docker/buildx/releases/download/v0.6.1/buildx-v0.6.1.linux-amd64 > /root/.docker/cli-plugins/docker-buildx && \
    chmod a+x /root/.docker/cli-plugins/docker-buildx

# Configura el entorno de compilación para Buildx
ENV DOCKER_CLI_EXPERIMENTAL=enabled
RUN docker buildx create --name mybuilder && \
    docker buildx use mybuilder && \
    docker buildx inspect --bootstrap

# Cambia el almacenamiento de Docker a 'vfs' (requerido para ejecutar Docker-in-Docker)
RUN echo '{ "storage-driver": "vfs", "log-level": "fatal" }' > /etc/docker/daemon.json

CMD sh -c 'dockerd -H unix:///var/run/docker.sock & until docker info >/dev/null 2>&1; do :; done; docker "$@"'