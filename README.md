# Terraform Docker Lab

This project provisions local Docker infrastructure with Terraform using the `kreuzwerker/docker` provider. It creates:

- A dedicated Docker network.
- A persistent Docker volume.
- An NGINX container with environment variables and mounted volume.

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
├── .github/workflows/terraform.yml   # CI/CD pipeline: fmt, validate, tflint, plan, optional apply/verify/destroy
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

## Manual workflow usage

In GitHub Actions:

1. Open **Terraform Docker Lab CI** workflow.
2. Click **Run workflow**.
3. Set `run_apply=true` to allow apply.
4. Optionally set `run_destroy=true` to auto-destroy after verification.

This protects your local and shared environments from accidental auto-apply.
