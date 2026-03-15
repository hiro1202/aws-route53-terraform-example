.PHONY: fmt tflint checkov trivy test

fmt:
	terraform fmt -recursive -diff

tflint:
	tflint --init && tflint --recursive --config $(CURDIR)/.tflint.hcl

checkov:
	checkov -d .

trivy:
	trivy config --quiet .

test:
	terraform -chdir=teams/platform/env/test/ap-northeast-1 init -backend=false
	terraform -chdir=teams/platform/env/test/ap-northeast-1 test
