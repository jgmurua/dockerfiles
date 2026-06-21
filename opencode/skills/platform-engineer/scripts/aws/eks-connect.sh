#!/usr/bin/env bash
set -euo pipefail

CLUSTER="${1:-}"
REGION="${2:-}"
PROFILE="${3:-}"

if [[ -z "$CLUSTER" || -z "$REGION" ]]; then
  echo "Usage: $0 <cluster-name> <region> [aws-profile]" >&2
  exit 1
fi

ARGS=(eks update-kubeconfig --name "$CLUSTER" --region "$REGION")
if [[ -n "$PROFILE" ]]; then
  ARGS+=(--profile "$PROFILE")
fi

aws sts get-caller-identity ${PROFILE:+--profile "$PROFILE"}
aws "${ARGS[@]}"
kubectl get nodes -o wide
