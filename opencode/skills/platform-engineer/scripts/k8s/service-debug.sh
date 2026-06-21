#!/usr/bin/env bash
set -euo pipefail

NS="${1:-}"
SVC="${2:-}"
if [[ -z "$NS" || -z "$SVC" ]]; then
  echo "Usage: $0 <namespace> <service>" >&2
  exit 1
fi

echo "== Service =="
kubectl -n "$NS" get svc "$SVC" -o yaml

echo
echo "== Endpoints =="
kubectl -n "$NS" get endpoints "$SVC" -o yaml || true

echo
echo "== EndpointSlices =="
kubectl -n "$NS" get endpointslice -l "kubernetes.io/service-name=$SVC" -o yaml || true

echo
echo "== Candidate pods by common app labels =="
APP_SELECTOR="$(kubectl -n "$NS" get svc "$SVC" -o jsonpath='{range $k,$v:=.spec.selector}{printf "%s=%s," $k $v}{end}' | sed 's/,$//')"
if [[ -n "$APP_SELECTOR" ]]; then
  echo "Selector: $APP_SELECTOR"
  kubectl -n "$NS" get pods -l "$APP_SELECTOR" -o wide --show-labels || true
else
  echo "Service has no selector"
fi
