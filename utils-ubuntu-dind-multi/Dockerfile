FROM ubuntu:22.10
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

# instala azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# install google cloud sdk
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
# instala terraform
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
# workdir y colores
RUN mkdir -p /workdir && echo "cd /workdir " >> /root/.bashrc && echo  " PS1='\[\033[01;32m\]Bash\[\033[01;30m\]: ' " >> /root/.bashrc
#agrega sshkey que esten en la carpeta ssh
COPY ssh/ /root/.ssh/
RUN chmod 600 /root/.ssh/*
RUN mkdir -p /pems
# git configs
RUN git config --global user.name "Tu nombre" && git config --global user.email "tuemail@tuemail.com"
# instala el ultimo kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# instala helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh
# instala kubelogin azure
RUN curl -fsSL -o kubelogin-linux-arm64.zip "https://github.com/Azure/kubelogin/releases/download/v0.0.30/kubelogin-linux-arm64.zip" && unzip -j kubelogin-linux-arm64.zip bin/linux_arm64/kubelogin -d /usr/local/bin/ && chmod +x /usr/local/bin/kubelogin && rm kubelogin-linux-arm64.zip
# kubeconfig root
RUN mkdir -p /root/.kube && chmod 700 /root/.kube 
# install lens 
RUN apt-get install libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 libnss3  libasound2  libnotify4 libxss1 xdg-utils libsecret-1-0 -y
RUN wget https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.5.2-309/OpenLens-6.5.2-309.amd64.deb && dpkg -i OpenLens-6.5.2-309.amd64.deb && rm OpenLens-6.5.2-309.amd64.deb
# alias start lens
RUN echo "alias lens=\"nohup sh -c 'open-lens --no-sandbox &'\"" >> /root/.bashrc

##Display
ENV DISPLAY=host.docker.internal:0.0

# iniciar docker y lens
#CMD nohup sh -c 'open-lens --no-sandbox &' && sh -c 'dockerd -H unix:///var/run/docker.sock & until docker info >/dev/null 2>&1; do :; done; bash "$@"'

CMD sh -c 'dockerd -H unix:///var/run/docker.sock & until docker info >/dev/null 2>&1; do :; done; bash "$@"'

