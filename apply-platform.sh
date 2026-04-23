#!/bin/bash
set -euo pipefail

BASE="/home/ubuntu/terraform-automation-agent/devops-75hard.github.io/env/dev/platform"

apply() {
  local dir="$1"
  echo ""
  echo "========================================"
  echo "  Applying: $dir"
  echo "========================================"
  cd "$dir"
  terraform init -reconfigure
  terraform apply -auto-approve
}

apply "$BASE/network"
apply "$BASE/iam"
apply "$BASE/eks"

echo ""
echo "All stacks applied successfully."
