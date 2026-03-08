.PHONY: fmt tflint checkov test

fmt:
	terraform fmt -recursive -diff

tflint:
	tflint --init && tflint --recursive --config $(CURDIR)/.tflint.hcl

checkov:
	checkov -d .

test:
	terraform -chdir=teams/platform/env/test/ap-northeast-1 init -backend=false
	terraform -chdir=teams/platform/env/test/ap-northeast-1 test
