FROM golang:1.26.4-bookworm AS helm-builder

ARG HELM_VERSION=v4.0.0

RUN git clone --depth 1 --branch ${HELM_VERSION} \
    https://github.com/helm/helm.git /src

WORKDIR /src

RUN make build && cp bin/helm /out-helm


FROM golang:1.26.4-bookworm AS tfswitch-builder

ARG TFSWITCH_VERSION=v1.19.0

RUN git clone --depth 1 --branch ${TFSWITCH_VERSION} \
    https://github.com/warrensbox/terraform-switcher.git /src

WORKDIR /src

RUN mkdir -p /out && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -trimpath -ldflags="-s -w" -o /out/tfswitch .


FROM ubuntu:26:04

USER root

ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER_CLI_EXPERIMENTAL=enabled

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    gnupg \
    lsb-release \
    software-properties-common \
    sudo \
    jq \
    mariadb-client \
    golang-go \
    python3 \
    python3-pip \
    nodejs \
    npm \
    wget \
    tmux \
    zip \
    unzip \
    vim \
    libnss3 \
    docker.io \
    containerd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.docker/cli-plugins && \
    wget -qO /root/.docker/cli-plugins/docker-buildx \
    https://github.com/docker/buildx/releases/download/v0.21.2/buildx-v0.21.2.linux-amd64 && \
    chmod +x /root/.docker/cli-plugins/docker-buildx

RUN echo '{ "storage-driver": "vfs", "log-level": "fatal" }' > /etc/docker/daemon.json

COPY --from=tfswitch-builder /out/tfswitch /usr/local/bin/tfswitch
COPY --from=helm-builder /out-helm /usr/local/bin/helm

RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
 && unzip /tmp/awscliv2.zip -d /tmp \
 && /tmp/aws/install \
 && rm -rf /tmp/aws /tmp/awscliv2.zip

ARG KUBECTL_VERSION=v1.36.0

RUN curl -fsSL -o /usr/local/bin/kubectl \
    "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && chmod +x /usr/local/bin/kubectl \
 && kubectl version --client=true

RUN cat > /usr/local/bin/start-dind.sh <<'EOF'
#!/usr/bin/env bash
set -e

dockerd -H unix:///var/run/docker.sock &

until docker info >/dev/null 2>&1; do
  sleep 1
done

docker buildx inspect mybuilder >/dev/null 2>&1 || docker buildx create --name mybuilder --use
docker buildx use mybuilder >/dev/null 2>&1 || true

exec bash
EOF

RUN chmod +x /usr/local/bin/start-dind.sh

WORKDIR /workspace

CMD ["/usr/local/bin/start-dind.sh"]