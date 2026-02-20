# Terraform Docker Lab

This lab is for practicing **Infrastructure as Code (IaC)** on your local machine using Terraform + Docker.
It helps you learn how to safely provision, verify, and destroy container infrastructure.

This project provisions local Docker infrastructure with Terraform using the `kreuzwerker/docker` provider. It creates:

- A dedicated Docker network.
- A persistent Docker volume.
- An NGINX container with environment variables and mounted volume.

## What this is for (short)

- Learn Terraform resource lifecycle (`plan`, `apply`, `destroy`) on local Docker.
- Practice safe CI that checks code quality without auto-applying infra changes.
- Validate a running service with a simple shell verification script.

## Safety first

- `terraform apply` is **not** executed automatically by CI on push/PR.
- Apply and destroy are available only in manual GitHub Actions runs (`workflow_dispatch`) with explicit flags.
- You should always review `terraform plan` before applying changes.

## Prerequisites

- Docker running locally.
- Terraform >= 1.5.
- `curl` for verification script.
- (Optional) `tflint` for local linting.

## Repository tree

```text
.
├── .github/workflows/terraform.yml   # CI pipeline: fmt, validate, tflint, plan, manual apply/verify/destroy
├── .tflint.hcl                       # TFLint configuration (compatible with newer TFLint versions)
├── main.tf                           # Docker network, volume, image, and container resources
├── outputs.tf                        # Useful output values (URL, container name, network)
├── scripts/verify.sh                 # Curl-based runtime verification for deployed container
├── terraform.tfvars.example          # Example variable values for local overrides
├── variables.tf                      # Input variables for names, ports, and env values
├── versions.tf                       # Terraform and provider constraints
└── CHEATSHEET.md                     # Quick command reference and troubleshooting
```

## Local usage

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

## CI pipeline stages

1. **fmt**: `terraform fmt -check -recursive`
2. **validate**: `terraform init -backend=false` + `terraform validate`
3. **tflint**: static analysis of Terraform files
4. **plan**: dry-run execution plan
5. **apply_and_verify** *(manual only)*: apply infrastructure then run `scripts/verify.sh`
6. **destroy** *(manual only)*: cleanup infrastructure after verification

## Issue seen in CI and how it was solved

**Issue:** TFLint job failed with:
`module` attribute was removed in v0.54.0. Use `call_module_type` instead.

**Cause:** `.tflint.hcl` used deprecated `config { module = false }`.

**Fix applied:** Updated config to:
`config { call_module_type = "none" }`

This makes the pipeline compatible with newer TFLint releases.

## Manual workflow usage

In GitHub Actions:

1. Open **Terraform Docker Lab CI** workflow.
2. Click **Run workflow**.
3. Set `run_apply=true` to allow apply.
4. Optionally set `run_destroy=true` to auto-destroy after verification.

This protects your local and shared environments from accidental auto-apply.
