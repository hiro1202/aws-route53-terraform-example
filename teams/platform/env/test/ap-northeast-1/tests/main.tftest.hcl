mock_provider "aws" {
  mock_data "aws_availability_zones" {
    defaults = {
      names = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
    }
  }
}

variables {
  aws_profile = "default"
  aws_region  = "ap-northeast-1"
  env                      = "test"
  resolver_rule_target_ips = ["192.168.1.1"]
}

# --- apply が正常に通ることを確認 ---
run "apply_succeeds" {
  command = apply
}
