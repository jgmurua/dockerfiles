#!/usr/bin/env bash
set -euo pipefail

NS="${1:-}"
ING="${2:-}"
if [[ -z "$NS" || -z "$ING" ]]; then
  echo "Usage: $0 <namespace> <ingress>" >&2
  exit 1
fi

echo "== Ingress =="
kubectl -n "$NS" get ingress "$ING" -o yaml

echo
echo "== IngressClass =="
kubectl get ingressclass || true

echo
echo "== Related services =="
for svc in $(kubectl -n "$NS" get ingress "$ING" -o jsonpath='{range .spec.rules[*].http.paths[*]}{.backend.service.name}{"\n"}{end}' | sort -u); do
  echo "-- Service: $svc"
  kubectl -n "$NS" get svc "$svc" -o wide || true
  kubectl -n "$NS" get endpoints "$svc" -o wide || true
done

echo
echo "== Potential controllers =="
kubectl get pods -A | grep -Ei 'ingress|nginx|traefik|gateway|alb|load-balancer' || true
