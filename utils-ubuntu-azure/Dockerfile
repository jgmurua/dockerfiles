FROM ubuntu:23.10
USER root
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Argentina/Buenos_Aires
# install packages and clean up
RUN apt-get update && apt-get install ca-certificates curl apt-transport-https lsb-release gnupg wget tmux zip vim git jq python3.10 -y
# instala azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# instala terraform
#RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
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
