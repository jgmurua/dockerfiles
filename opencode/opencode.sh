#!/usr/bin/env bash

docker run --rm -it \
  -v "$PWD:/workspace" \
  -v "$HOME/.kube:/root/.kube:ro" \
  -v "$HOME/.aws:/root/.aws:ro" \
  -e AWS_PROFILE \
  -w /workspace \
  opencode-cli
