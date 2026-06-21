FROM ubuntu:26:04
USER root

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y -qq --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    docker.io \
    jq

RUN curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | \
    gpg --dearmor -o /usr/share/keyrings/trivy.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/trivy.list && \
    apt-get update && \
    apt-get install -y -qq trivy

RUN trivy image --download-db-only --no-progress --quiet

ENTRYPOINT ["trivy"]
