# Terraform Docker Lab Cheat Sheet

## Core commands

- `terraform init` — download provider plugins and initialize working directory.
- `terraform fmt -recursive` — format Terraform files.
- `terraform validate` — validate syntax and configuration graph.
- `terraform plan` — preview what Terraform will create/update/destroy.
- `terraform apply` — create/update Docker resources.
- `terraform destroy` — remove all managed Docker resources.

## Variable handling

- `cp terraform.tfvars.example terraform.tfvars` — start from a local variable file.
- `terraform plan -var='nginx_port=9090'` — override a single variable quickly.

## Verification

- `./scripts/verify.sh` — verify default URL and expected text.
- `./scripts/verify.sh http://localhost:8080 "Hello from Terraform Docker Lab"` — explicit verification parameters.

## Helpful Docker checks

- `docker ps` — confirm container is running.
- `docker network ls` — confirm network exists.
- `docker volume ls` — confirm volume exists.

## CI manual apply/destroy

- Trigger GitHub workflow with `run_apply=true` to execute apply + verify.
- Add `run_destroy=true` to destroy infrastructure after verify in the same manual run.
