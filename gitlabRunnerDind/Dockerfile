# Usa Ubuntu 24.04 como base
FROM ubuntu:24.04
USER root
ARG RUNNER_VERSION="16.4.0"  # Define la versión de GitLab Runner
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author=""
LABEL Email=""
LABEL GitLab=""
LABEL BaseImage="ubuntu:24.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# Instala los paquetes necesarios
RUN apt-get update && \
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
    dumb-init \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Instala Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Cambia el almacenamiento de Docker a 'vfs' (requerido para ejecutar Docker-in-Docker)
RUN echo '{ "storage-driver": "vfs", "log-level": "fatal" }' > /etc/docker/daemon.json

# Instala GitLab Runner
RUN curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/v${RUNNER_VERSION}/binaries/gitlab-runner-linux-amd64 && \
    chmod +x /usr/local/bin/gitlab-runner && \
    gitlab-runner --version

# Inicia Docker Daemon
RUN dockerd -H unix:///var/run/docker.sock &

# Crea un directorio de trabajo para GitLab Runner
RUN mkdir -p /etc/gitlab-runner
WORKDIR /etc/gitlab-runner

# Copia el script de inicio
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Define el entrypoint usando dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/start.sh"]
