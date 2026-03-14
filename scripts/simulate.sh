#!/usr/bin/env bash
set -euo pipefail

PORT="${1:-8080}"
MESSAGE="${2:-Hello from Terraform Docker Lab}"

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1"
    exit 1
  }
}

need_cmd terraform
need_cmd docker
need_cmd curl

export TF_IN_AUTOMATION=1
export TF_INPUT=0

cleanup() {
  echo "[cleanup] Destroying infrastructure..."
  terraform destroy -auto-approve -var="nginx_port=${PORT}" -var="welcome_message=${MESSAGE}" || true
}
trap cleanup EXIT

echo "[1/7] terraform init"
terraform init

echo "[2/7] terraform fmt -check -recursive"
terraform fmt -check -recursive

echo "[3/7] terraform validate"
terraform validate

echo "[4/7] terraform plan"
terraform plan -out=simulation.tfplan -var="nginx_port=${PORT}" -var="welcome_message=${MESSAGE}"

echo "[5/7] terraform apply"
terraform apply -auto-approve simulation.tfplan

echo "[6/7] verify endpoint"
./scripts/verify.sh "http://localhost:${PORT}" "${MESSAGE}"

echo "[info] verifying Redis sidecar exists"
docker ps --format '{{.Names}}' | grep -q "$(terraform output -raw redis_container_name)"

echo "[7/7] simulation completed successfully"
