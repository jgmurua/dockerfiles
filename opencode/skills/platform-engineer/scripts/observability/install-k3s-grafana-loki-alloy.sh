#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${NAMESPACE:-observability}"
GRAFANA_ADMIN_USER="${GRAFANA_ADMIN_USER:-admin}"
GRAFANA_ADMIN_PASSWORD="${GRAFANA_ADMIN_PASSWORD:-admin12345}"
LOKI_VALUES="${LOKI_VALUES:-templates/observability/loki-values-filesystem.yaml}"
ALLOY_VALUES="${ALLOY_VALUES:-templates/observability/alloy-values.yaml}"
GRAFANA_VALUES="${GRAFANA_VALUES:-templates/observability/grafana-values.yaml}"

command -v kubectl >/dev/null || { echo "kubectl not found" >&2; exit 1; }
command -v helm >/dev/null || { echo "helm not found" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
cd "$SKILL_DIR"

helm repo add grafana https://grafana.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install loki grafana/loki \
  -n "$NAMESPACE" \
  -f "$LOKI_VALUES" \
  --atomic --timeout 10m

helm upgrade --install alloy grafana/alloy \
  -n "$NAMESPACE" \
  -f "$ALLOY_VALUES" \
  --atomic --timeout 10m

helm upgrade --install grafana grafana/grafana \
  -n "$NAMESPACE" \
  -f "$GRAFANA_VALUES" \
  --set "adminUser=$GRAFANA_ADMIN_USER" \
  --set "adminPassword=$GRAFANA_ADMIN_PASSWORD" \
  --atomic --timeout 10m

kubectl -n "$NAMESPACE" get pods,svc,pvc
cat <<EOF

Grafana:
  kubectl -n $NAMESPACE port-forward svc/grafana 3000:80
  URL: http://localhost:3000
  user: $GRAFANA_ADMIN_USER
  pass: $GRAFANA_ADMIN_PASSWORD
EOF
