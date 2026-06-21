#!/usr/bin/env bash
set -euo pipefail

NS="${1:-default}"
TARGET="${2:-kubernetes.default}"
POD="dns-debug-$(date +%s)"

echo "Creating temporary DNS debug pod in namespace: $NS"
kubectl -n "$NS" run "$POD" --image=registry.k8s.io/e2e-test-images/agnhost:2.45 --restart=Never -- sleep 300
kubectl -n "$NS" wait --for=condition=Ready pod/"$POD" --timeout=90s

echo
echo "== /etc/resolv.conf =="
kubectl -n "$NS" exec "$POD" -- cat /etc/resolv.conf

echo
echo "== nslookup $TARGET =="
kubectl -n "$NS" exec "$POD" -- nslookup "$TARGET" || true

echo
echo "== CoreDNS pods =="
kubectl -n kube-system get pods -l k8s-app=kube-dns -o wide || true

echo
echo "Cleaning up $POD"
kubectl -n "$NS" delete pod "$POD" --ignore-not-found=true
