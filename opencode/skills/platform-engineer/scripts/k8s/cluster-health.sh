#!/usr/bin/env bash
set -euo pipefail

CTX="$(kubectl config current-context 2>/dev/null || true)"
echo "== Kubernetes cluster health =="
echo "Context: ${CTX:-unknown}"
echo

echo "== Nodes =="
kubectl get nodes -o wide

echo
echo "== Non-running pods =="
kubectl get pods -A -o wide | awk 'NR==1 || $4 != "Running" {print}'

echo
echo "== Recent events =="
kubectl get events -A --sort-by=.lastTimestamp | tail -120

echo
echo "== Workloads =="
kubectl get deploy,sts,ds -A

echo
echo "== Storage =="
kubectl get pvc -A || true

echo
echo "== Metrics if available =="
kubectl top nodes 2>/dev/null || echo "metrics-server not available for nodes"
kubectl top pods -A --containers 2>/dev/null | head -80 || echo "metrics-server not available for pods"
