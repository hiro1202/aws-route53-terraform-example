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
    condition     = length(module.network.private_subnet_cidrs) == 2
    error_message = "Private subnet count should be 2"
  }

  assert {
    condition     = module.network.private_subnet_cidrs[0] == "10.0.0.0/24"
    error_message = "Private subnet CIDR[0] should be 10.0.0.0/24"
  }

  assert {
    condition     = module.network.private_subnet_cidrs[1] == "10.0.1.0/24"
    error_message = "Private subnet CIDR[1] should be 10.0.1.0/24"
  }
}

# --- INBOUND のとき direction が INBOUND になること ---
run "inbound_direction" {
  command = plan

  module {
    source = "../../../../../modules/route53/resolver/endpoint"
  }

  variables {
    direction           = "INBOUND"
    endpoint_name       = "test-inbound"
    vpc_id              = "vpc-12345678"
    subnet_ids          = ["subnet-aaaa", "subnet-bbbb"]
    allowed_cidr_blocks = ["10.0.0.0/16"]
  }

  assert {
    condition     = aws_route53_resolver_endpoint.main.direction == "INBOUND"
    error_message = "direction が INBOUND であること"
  }
}

# --- OUTBOUND のとき direction が OUTBOUND になること ---
run "outbound_direction" {
  command = plan

  module {
    source = "../../../../../modules/route53/resolver/endpoint"
  }

  variables {
    direction           = "OUTBOUND"
    endpoint_name       = "test-outbound"
    vpc_id              = "vpc-12345678"
    subnet_ids          = ["subnet-aaaa", "subnet-bbbb"]
    allowed_cidr_blocks = ["10.0.0.0/16"]
  }

  assert {
    condition     = aws_route53_resolver_endpoint.main.direction == "OUTBOUND"
    error_message = "direction が OUTBOUND であること"
  }
}
