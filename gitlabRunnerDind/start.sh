#!/bin/bash

# Inicia Docker Daemon en segundo plano
dockerd -H unix:///var/run/docker.sock &

# Registra el GitLab Runner si no está registrado
if [[ ! -f /etc/gitlab-runner/config.toml ]]; then
  gitlab-runner register \
    --non-interactive \
    --url "$CI_SERVER_URL" \
    --registration-token "$REGISTRATION_TOKEN" \
    --executor "docker" \
    --docker-image "ubuntu:latest" \
    --description "GitLab Runner" \
    --tag-list "docker,linux" \
    --run-untagged="true" \
    --locked="false"
fi

# Inicia el GitLab Runner en modo de espera
gitlab-runner run --user=root --working-directory=/etc/gitlab-runner
