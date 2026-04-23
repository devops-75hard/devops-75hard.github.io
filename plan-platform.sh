#!/bin/bash
set -euo pipefail

BASE="/home/ubuntu/terraform-automation-agent/devops-75hard.github.io/env/dev/platform"

plan() {
  local dir="$1"
  echo ""
  echo "========================================"
  echo "  Planning: $dir"
  echo "========================================"
  cd "$dir"
  terraform init -reconfigure
  terraform plan
}

plan "$BASE/network"
plan "$BASE/iam"
plan "$BASE/eks"

echo ""
echo "All plans complete."
