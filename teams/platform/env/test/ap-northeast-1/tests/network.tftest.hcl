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

run "network_plan" {
  command = plan

  assert {
    condition     = module.network.vpc_cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block should be 10.0.0.0/16"
  }

  assert {
    condition     = length(module.network.private_subnet_cidrs) == 1
    error_message = "Private subnet count should be 1"
  }

  assert {
    condition     = module.network.private_subnet_cidrs[0] == "10.0.0.0/24"
    error_message = "Private subnet CIDR should be 10.0.0.0/24"
  }
}
