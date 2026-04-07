# Terraform Docker Lab — Local Dev Guide

Step-by-step workflow for running this lab locally. Covers init, plan, apply, verify, and destroy.

---

## Prerequisites

```bash
# Verify Docker is running
docker info

# Verify Terraform is installed
terraform version

# Terraform 1.6+ is required for this lab
```

---

## First-Time Setup

```bash
# 1. Initialize Terraform (downloads Docker provider)
terraform init

# Output should show:
# Terraform has been successfully initialized!
# Provider registry.terraform.io/kreuzwerker/docker v3.x.x

# 2. Validate the configuration
terraform validate

# 3. Format check (CI enforces this)
terraform fmt -check -recursive
```

---

## Standard Workflow

```bash
# 1. Plan (always before apply)
terraform plan -out=tfplan

# Review the output — check:
# - Resources being created (green +)
# - Resources being modified (yellow ~)
# - Resources being destroyed (red -)

# 2. Apply
terraform apply tfplan

# 3. Verify containers are running
docker ps | grep terraform-docker-lab

# 4. Run the verification script
bash scripts/verify.sh

# 5. Run the simulation script
bash scripts/simulate.sh
```

---

## Teardown

```bash
# Remove all resources Terraform created
terraform destroy

# Confirm at the prompt: Enter 'yes' to destroy all resources

# Verify nothing is left
docker ps | grep terraform-docker-lab
```

**Why explicit destroy?** Terraform destroy removes only what's in the state file. If you manually created resources alongside the Terraform-managed ones, those remain.

---

## State File

Terraform tracks what it created in `terraform.tfstate`. In this lab it's local.

```bash
# View current state
terraform state list

# Inspect a specific resource
terraform state show docker_container.app

# If state gets corrupted, start fresh (CAREFUL: this orphans real resources)
rm terraform.tfstate terraform.tfstate.backup
terraform init
```

**Warning**: Never delete the state file while real infrastructure exists. Terraform will think nothing exists and try to create everything again, causing conflicts.

---

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| `Error: Docker daemon not running` | Docker Desktop not started | Start Docker Desktop |
| `Error: port already in use` | Another container uses the same port | Change `host_path` in `variables.tf` |
| `Plan shows destroy + create` | Force-replace due to changed immutable field | Normal — inspect what changed |
| `terraform: command not found` | Terraform not in PATH | Install via `tfenv` or add to PATH |
| `Error: Invalid provider configuration` | Wrong provider version | Run `terraform init -upgrade` |
