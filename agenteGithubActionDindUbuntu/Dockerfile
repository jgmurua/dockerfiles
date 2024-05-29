# Usa Ubuntu 24.04 como base
FROM ubuntu:24.04
USER root
ARG RUNNER_VERSION="2.316.1"
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author=""
LABEL Email=""
LABEL GitHub=""
LABEL BaseImage="ubuntu:24.04"
LABEL RunnerVersion=${RUNNER_VERSION}


# Instala los paquetes necesarios
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    dnsutils \
    wget \
    git \
    jq \
    iputils-ping \
    software-properties-common \
    sudo \
    libcurl4 \
    libunwind8 \
    netcat-openbsd \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# DOCKER

# Añade la clave GPG de Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Añade el repositorio de Docker
RUN echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instala Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Cambia el almacenamiento de Docker a 'vfs' (requerido para ejecutar Docker-in-Docker)
RUN echo '{ "storage-driver": "vfs", "log-level": "fatal" }' > /etc/docker/daemon.json

###incluir en el Entrypoint dockerd -H unix:///var/run/docker.sock &  y de esa manera docker estara configurado y corriendo

# instalar agente github Action
RUN mkdir -p /azp
WORKDIR /azp


# Instala el agente de GitHub

RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm -f ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    ./bin/installdependencies.sh


# --------------------AGENTE---------------------------------


# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]
