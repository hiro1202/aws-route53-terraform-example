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
  env         = "test"
}

# --- plan が正常に通ることを確認するスモークテスト ---
run "plan_succeeds" {
  command = plan
}
