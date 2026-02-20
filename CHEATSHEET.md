# Terraform Docker Lab Cheat Sheet

## Setup

- `cp terraform.tfvars.example terraform.tfvars` — create local variable file.
- `terraform init` — download provider plugins and initialize.
- `terraform providers` — show required and installed providers.

## Quality checks

- `terraform fmt -recursive` — format files.
- `terraform fmt -check -recursive` — check formatting in CI style.
- `terraform validate` — validate configuration.
- `tflint --init && tflint` — run Terraform linting rules.

## Plan / Apply / Destroy

- `terraform plan` — preview changes.
- `terraform plan -out=tfplan` — save reviewed plan.
- `terraform apply tfplan` — apply exactly saved plan.
- `terraform apply -auto-approve` — apply without prompt (use carefully).
- `terraform destroy` — destroy managed resources.
- `terraform destroy -auto-approve` — non-interactive cleanup.

## Variables

- `terraform plan -var='nginx_port=9090'` — one-off override.
- `terraform plan -var='welcome_message=Hi'` — customize web content.
- `terraform plan -var-file='terraform.tfvars'` — use explicit vars file.

## Outputs and state

- `terraform output` — show all outputs.
- `terraform output application_url` — print app URL.
- `terraform state list` — list tracked resources.
- `terraform show` — inspect current state.

## Verify and debug runtime

- `./scripts/verify.sh` — verify default URL and expected text.
- `./scripts/verify.sh http://localhost:8080 "Hello from Terraform Docker Lab"` — custom verify.
- `curl -i http://localhost:8080` — inspect HTTP response.
- `docker ps` — check running container.
- `docker logs lab-nginx` — inspect startup/runtime logs.
- `docker inspect lab-nginx` — check env, ports, and mounts.
- `docker network ls` — verify network creation.
- `docker volume ls` — verify volume creation.

## Full simulation

- `./scripts/simulate.sh` — full local flow (init, fmt-check, validate, plan, apply, verify, destroy).
- `./scripts/simulate.sh 8090 "Lab OK"` — simulation with custom port/message.

## CI behavior

- Push/PR: `fmt` → `validate` → `tflint` → `plan`.
- Manual (`workflow_dispatch`): optional `apply_and_verify`, optional `destroy`.
- Safety default: no auto-apply on push/PR.
