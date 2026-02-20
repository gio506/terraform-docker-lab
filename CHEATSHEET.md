# Terraform Docker Lab Cheat Sheet

## Core Terraform commands

- `terraform init` — initialize working directory and download providers.
- `terraform fmt -recursive` — format Terraform files.
- `terraform validate` — check syntax and internal consistency.
- `terraform plan` — preview infrastructure changes safely.
- `terraform apply` — create/update Docker infrastructure.
- `terraform destroy` — remove all Terraform-managed resources.

## Useful planning/apply variants

- `terraform plan -out=tfplan` — save plan file for later apply.
- `terraform apply tfplan` — apply exactly what was planned.
- `terraform apply -auto-approve` — skip prompt (use carefully).
- `terraform destroy -auto-approve` — non-interactive cleanup.

## Variable handling

- `cp terraform.tfvars.example terraform.tfvars` — create local variable file.
- `terraform plan -var='nginx_port=9090'` — quick one-off override.
- `terraform plan -var-file='terraform.tfvars'` — use explicit variable file.

## State and outputs

- `terraform state list` — list managed resources in state.
- `terraform output` — show all output values.
- `terraform output application_url` — show only the app URL output.

## Verification and debugging

- `./scripts/verify.sh` — check default URL/text.
- `./scripts/verify.sh http://localhost:8080 "Hello from Terraform Docker Lab"` — custom check.
- `curl -i http://localhost:8080` — inspect HTTP headers + body.
- `docker logs lab-nginx` — inspect container logs.

## Docker quick checks

- `docker ps` — confirm container is running.
- `docker network ls` — confirm network exists.
- `docker volume ls` — confirm volume exists.
- `docker inspect lab-nginx` — inspect runtime config/env/ports.

## TFLint and CI notes

- `tflint --init && tflint` — run local linting.
- If TFLint errors about `module` deprecation, use `call_module_type` in `.tflint.hcl`.
- CI apply/destroy are manual only through `workflow_dispatch` inputs.
