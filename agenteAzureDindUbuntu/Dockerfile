# Usa Ubuntu 22.10 como base
FROM ubuntu:22.10

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
    software-properties-common \
    sudo

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

# --------------------AGENTE---------------------------------

USER root
# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh
ENTRYPOINT [ "./start.sh" ]
