fmt:
	terraform fmt -recursive

validate:
	terraform init -backend=false
	terraform validate

plan:
	terraform init -backend=false
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy

verify:
	./scripts/verify.sh
