.PHONY: lint checkov test test-modules test-module-resolver-endpoint test-root-modules test-root-module-platform

lint: checkov

checkov:
	checkov -d .

test: test-modules test-root-modules

# --- 子モジュールテスト ---
test-modules: test-module-resolver-endpoint

test-module-resolver-endpoint:
	terraform -chdir=modules/route53/resolver/endpoint init -backend=false
	terraform -chdir=modules/route53/resolver/endpoint test

# --- ルートモジュールテスト ---
test-root-modules: test-root-module-platform

test-root-module-platform:
	terraform -chdir=teams/platform/env/test/ap-northeast-1 init -backend=false
	terraform -chdir=teams/platform/env/test/ap-northeast-1 test
