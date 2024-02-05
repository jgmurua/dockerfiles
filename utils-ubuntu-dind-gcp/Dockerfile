FROM ubuntu:23.10
USER root
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Argentina/Buenos_Aires
# install packages and clean up
RUN apt-get update && apt-get install ca-certificates curl apt-transport-https lsb-release gnupg software-properties-common awscli mariadb-client golang sudo wget tmux zip unzip vim git jq python3.10 libnss3 -y

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

# install google cloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash && PATH=$PATH:/root/google-cloud-sdk/bin
# instala terraform
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
# instala el ultimo kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# instala helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh
# kubeconfig root
RUN mkdir -p /root/.kube && chmod 700 /root/.kube 

CMD sh -c 'dockerd -H unix:///var/run/docker.sock & until docker info >/dev/null 2>&1; do :; done; bash "$@"'

