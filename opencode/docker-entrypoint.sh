#!/usr/bin/env bash
set -euo pipefail

mkdir -p "${OPENCODE_CONFIG_DIR:-$HOME/.config/opencode}" \
         "${XDG_DATA_HOME:-$HOME/.local/share}/opencode" \
         "${XDG_CACHE_HOME:-$HOME/.cache}/opencode" \
         "${XDG_STATE_HOME:-$HOME/.local/state}/opencode" 2>/dev/null || true

# Avoid Git's "dubious ownership" only for the mounted project, not globally for every path.
if command -v git >/dev/null 2>&1 && [ -d /workspace ]; then
  git config --global --add safe.directory /workspace 2>/dev/null || true
fi

exec opencode "$@"
