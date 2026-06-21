#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-observability}"
LOCAL_PORT="${2:-3000}"
SERVICE="${3:-grafana}"

echo "Forwarding Grafana: http://localhost:${LOCAL_PORT}"
kubectl -n "$NAMESPACE" port-forward "svc/${SERVICE}" "${LOCAL_PORT}:80"
