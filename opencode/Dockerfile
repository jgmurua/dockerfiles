FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        jq \
        openssh-client \
        tar \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode using the official installer. No secrets are baked into the image.
ENV HOME=/opt/opencode
RUN mkdir -p /opt/opencode \
    && curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path \
    && ln -s /opt/opencode/.opencode/bin/opencode /usr/local/bin/opencode \
    && opencode --version

RUN groupadd --gid 1000 opencode \
    && useradd --uid 1000 --gid 1000 --create-home --home-dir /home/opencode --shell /bin/bash opencode \
    && mkdir -p /workspace /home/opencode/.config /home/opencode/.local/share /home/opencode/.cache /home/opencode/.local/state \
    && chown -R opencode:opencode /workspace /home/opencode

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

ENV HOME=/home/opencode \
    XDG_CONFIG_HOME=/home/opencode/.config \
    XDG_DATA_HOME=/home/opencode/.local/share \
    XDG_CACHE_HOME=/home/opencode/.cache \
    XDG_STATE_HOME=/home/opencode/.local/state \
    OPENCODE_CONFIG_DIR=/home/opencode/.config/opencode \
    GIT_CONFIG_GLOBAL=/home/opencode/.config/opencode/gitconfig

WORKDIR /workspace
USER opencode
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
