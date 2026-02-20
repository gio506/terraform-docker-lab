# Terraform Docker Lab

This lab is for practicing **Infrastructure as Code (IaC)** locally with Terraform + Docker.
It provisions a safe demo environment so you can practice `plan`, `apply`, `verify`, and `destroy` workflows.

## What this provisions

- Docker network (`docker_network`)
- Docker volume (`docker_volume`)
- NGINX container (`docker_container`) with:
  - environment variables (`APP_ENV`, `WELCOME_MESSAGE`)
  - mounted Docker volume at `/usr/share/nginx/html`
  - host port mapping to container port 80

## Why this is useful

- Hands-on Terraform lifecycle practice on local infra.
- Safe CI defaults (no automatic apply/destroy on push/PR).
- Repeatable verification via shell scripts.

## Safety model

- CI always runs `fmt`, `validate`, `tflint`, and `plan`.
- `apply` and `destroy` are manual-only (`workflow_dispatch`) and opt-in flags.
- Manual apply uses a saved plan artifact (`tfplan`) for predictable execution.

## Repository tree

```text
.
├── .github/workflows/terraform.yml   # CI pipeline (checks + manual apply/destroy)
├── .tflint.hcl                       # TFLint config (uses call_module_type, not deprecated module)
├── .gitignore                        # Terraform local/state/plan ignore rules
├── CHEATSHEET.md                     # Compact command reference
├── main.tf                           # Docker resources
├── outputs.tf                        # Output values (URL, names)
├── scripts/verify.sh                 # Runtime verification via curl
├── scripts/simulate.sh               # End-to-end local simulation (init->apply->verify->destroy)
├── terraform.tfvars.example          # Example variable file
├── variables.tf                      # Input variables
└── versions.tf                       # Terraform/provider constraints
```

## Prerequisites

- Docker running locally
- Terraform >= 1.5
- curl
- Optional: tflint

## Quick start

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
./scripts/verify.sh http://localhost:8080 "Hello from Terraform Docker Lab"
terraform destroy
```

## Local simulation (recommended)

Run a full realistic dry run + deploy + verify + cleanup flow:

```bash
./scripts/simulate.sh
```

Custom port/message:

```bash
./scripts/simulate.sh 8090 "Lab is healthy"
```

## CI issue that was fixed

**Issue:** `tflint` failed because `.tflint.hcl` used deprecated `module`.

**Fix:** replaced with `call_module_type = "none"` (required for newer TFLint versions).

## Official documentation

- Terraform CLI docs: <https://developer.hashicorp.com/terraform/cli>
- Terraform Docker provider docs: <https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs>
- TFLint docs: <https://github.com/terraform-linters/tflint>
