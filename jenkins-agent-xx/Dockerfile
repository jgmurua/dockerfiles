FROM jenkins/inbound-agent:latest
USER root

RUN apt-get update -y
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
RUN apt-get install -y vim git awscli jq python3.9 cowsay curl unzip wget

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
RUN chmod +x kubectl && mkdir -p ~/.local/bin && mv ./kubectl ~/.local/bin/kubectl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install terraform 1.4
RUN curl -o terraform_1.4.0_linux_amd64.zip https://releases.hashicorp.com/terraform/1.4.0/terraform_1.4.0_linux_amd64.zip && \
    unzip terraform_1.4.0_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform_1.4 && \
    rm -rf terraform_1.4.0_linux_amd64.zip

USER jenkins
ENTRYPOINT ["/usr/local/bin/jenkins-agent"]