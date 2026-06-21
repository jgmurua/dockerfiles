#!/usr/bin/env bash
set -euo pipefail

DIR="${1:-.}"
PLAN="${2:-tfplan}"

cd "$DIR"

echo "== Terraform fmt =="
terraform fmt -recursive -check

echo
echo "== Terraform init =="
terraform init

echo
echo "== Terraform validate =="
terraform validate

echo
echo "== Terraform plan =="
terraform plan -out="$PLAN"

echo
echo "Plan saved to: $(pwd)/$PLAN"
echo "Review with: terraform show $PLAN"
echo "Apply with: terraform apply $PLAN"
