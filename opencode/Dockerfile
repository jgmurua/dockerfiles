# helm3 building stage begin
FROM golang:1.26.4-bookworm AS helm-builder

ARG HELM_VERSION=v4.0.0

RUN git clone \
    --depth 1 \
    --branch ${HELM_VERSION} \
    https://github.com/helm/helm.git \
    /src

WORKDIR /src

RUN make build

RUN cp bin/helm /out-helm
# helm3 building stage end

# tfswitch building stage begin
FROM golang:1.26.4-bookworm AS tfswitch-builder

ARG TFSWITCH_VERSION=v1.19.0

RUN git clone --depth 1 --branch ${TFSWITCH_VERSION} \
    https://github.com/warrensbox/terraform-switcher.git /src

WORKDIR /src

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -trimpath -ldflags="-s -w" -o /out/tfswitch .

# tfswitch building stage end


FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    unzip \
    git \
    gnupg \
    lsb-release \
    sudo \
    jq \
    python3 \
    python3-pip \
    nodejs \
    npm \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

#tfswitch
COPY --from=tfswitch-builder /out/tfswitch /usr/local/bin/tfswitch

RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip

ARG KUBECTL_VERSION=v1.36.0

RUN curl -fsSL -o /usr/local/bin/kubectl \
    "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
 && chmod +x /usr/local/bin/kubectl \
 && kubectl version --client=true

COPY --from=helm-builder /out-helm /usr/local/bin/helm

RUN mkdir -p /root/.config/opencode/skills /root/.config/opencode

COPY skills/platform-engineer/ /root/.config/opencode/skills/platform-engineer/
COPY opencode.json /root/.config/opencode/opencode.json

RUN test -f /root/.config/opencode/skills/platform-engineer/SKILL.md \
    && chmod +x /root/.config/opencode/skills/platform-engineer/scripts/*.sh || true

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /workspace

ENTRYPOINT ["docker-entrypoint.sh"]
