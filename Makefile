.PHONY: test test-modules test-integration

test: test-modules test-integration

# --- モジュール単体テスト ---
test-modules: test-module-resolver-endpoint

test-module-resolver-endpoint:
	terraform -chdir=modules/route53/resolver/endpoint init -backend=false
	terraform -chdir=modules/route53/resolver/endpoint test

# --- 結合テスト ---
test-integration: test-integration-platform

test-integration-platform:
	terraform -chdir=teams/platform/env/test/ap-northeast-1 init -backend=false
	terraform -chdir=teams/platform/env/test/ap-northeast-1 test
