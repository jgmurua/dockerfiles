# Usa la imagen base con soporte multiarch
FROM --platform=$BUILDPLATFORM ubuntu:22.10
USER root

ARG GITEA_INSTANCE_URL
ARG GITEA_RUNNER_REGISTRATION_TOKEN

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

# install gitea act runner

RUN wget -qO- https://dl.gitea.com/act_runner/nightly/act_runner-nightly-linux-amd64 > /usr/local/bin/act_runner && \
    chmod a+x /usr/local/bin/act_runner
#install  node20 npm 
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# install google cloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash && PATH=$PATH:/root/google-cloud-sdk/bin

# instala azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# instala aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# instala terraform
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

# instala el ultimo kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# instala helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh

# kubeconfig root
RUN mkdir -p /root/.kube && chmod 700 /root/.kube 


CMD sh -c 'dockerd -H unix:///var/run/docker.sock & until docker info >/dev/null 2>&1; do :; done; sleep 5; /usr/local/bin/act_runner register --instance $GITEA_INSTANCE_URL --token $GITEA_RUNNER_REGISTRATION_TOKEN --no-interactive --name k8s-act --labels ubuntu-22.04:host; /usr/local/bin/act_runner daemon; sleep 999999999999'