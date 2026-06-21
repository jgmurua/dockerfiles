#!/usr/bin/env bash
set -euo pipefail

NS="${1:-}"
POD="${2:-}"

if [[ -z "$NS" || -z "$POD" ]]; then
  echo "Usage: $0 <namespace> <pod>" >&2
  exit 1
fi

echo "== Pod =="
kubectl -n "$NS" get pod "$POD" -o wide

echo
echo "== Describe =="
kubectl -n "$NS" describe pod "$POD"

echo
echo "== Current logs, all containers =="
kubectl -n "$NS" logs "$POD" --all-containers --tail=250 || true

echo
echo "== Previous logs, all containers =="
kubectl -n "$NS" logs "$POD" --all-containers --previous --tail=250 || true

echo
echo "== Recent namespace events =="
kubectl -n "$NS" get events --sort-by=.lastTimestamp | tail -100

echo
echo "== Owner references =="
kubectl -n "$NS" get pod "$POD" -o jsonpath='{.metadata.ownerReferences}' || true
echo
