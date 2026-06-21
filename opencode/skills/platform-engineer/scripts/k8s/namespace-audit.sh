#!/usr/bin/env bash
set -euo pipefail

NS="${1:-}"
if [[ -z "$NS" ]]; then
  echo "Usage: $0 <namespace>" >&2
  exit 1
fi

echo "== Namespace: $NS =="
kubectl get ns "$NS" -o yaml

echo
echo "== Resources =="
kubectl -n "$NS" get all -o wide

echo
echo "== Config =="
kubectl -n "$NS" get cm,secret,sa,role,rolebinding

echo
echo "== Network and storage =="
kubectl -n "$NS" get svc,ingress,networkpolicy,pvc

echo
echo "== Events =="
kubectl -n "$NS" get events --sort-by=.lastTimestamp | tail -120
