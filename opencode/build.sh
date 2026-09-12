#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="opencode-local:latest"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Building ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"
echo "==> Done: ${IMAGE_NAME}"
