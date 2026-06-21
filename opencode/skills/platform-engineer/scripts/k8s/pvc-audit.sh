#!/usr/bin/env bash
set -euo pipefail

echo "== StorageClasses =="
kubectl get storageclass

echo
echo "== PVCs =="
kubectl get pvc -A -o wide

echo
echo "== PVs =="
kubectl get pv -o wide

echo
echo "== PVC-related events =="
kubectl get events -A --sort-by=.lastTimestamp | grep -Ei 'pvc|persistentvolume|volume|mount|attach' | tail -120 || true
