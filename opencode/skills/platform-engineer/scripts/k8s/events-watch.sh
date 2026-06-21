#!/usr/bin/env bash
set -euo pipefail

NS="${1:-}"
if [[ -n "$NS" ]]; then
  watch -n 2 "kubectl -n '$NS' get events --sort-by=.lastTimestamp | tail -40"
else
  watch -n 2 "kubectl get events -A --sort-by=.lastTimestamp | tail -50"
fi
