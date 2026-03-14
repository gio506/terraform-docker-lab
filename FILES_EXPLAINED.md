# Files Explained

- `.github/workflows/terraform.yml`: 6-stage pipeline for fmt, validate, tflint, plan, optional apply, and optional destroy.
- `.tflint.hcl`: Terraform lint settings.
- `CHEATSHEET.md`: quick command reference.
- `FILES_EXPLAINED.md`: short purpose statement for every tracked file.
- `Makefile`: convenience targets for fmt, validate, plan, apply, destroy, and verify.
- `README.md`: main lab guide and safety model.
- `main.tf`: Docker network, volume, nginx, and redis resources.
- `outputs.tf`: exported runtime values.
- `scripts/simulate.sh`: local end-to-end apply, verify, and destroy flow.
- `scripts/verify.sh`: HTTP verification of the nginx page.
- `terraform.tfvars.example`: sample variable overrides.
- `variables.tf`: Terraform input definitions.
- `versions.tf`: Terraform and provider version constraints.
