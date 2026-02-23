test {
  parallel = true
}

mock_provider "aws" {}

# --- INBOUND のとき direction が INBOUND になること ---
run "inbound_direction" {
  command = apply

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
  command = apply

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

# --- resolver_endpoint_type のデフォルトが IPV4 であること ---
run "default_endpoint_type_is_ipv4" {
  command = apply

  variables {
    direction           = "INBOUND"
    endpoint_name       = "test-default-type"
    vpc_id              = "vpc-12345678"
    subnet_ids          = ["subnet-aaaa", "subnet-bbbb"]
    allowed_cidr_blocks = ["10.0.0.0/16"]
  }

  assert {
    condition     = aws_route53_resolver_endpoint.main.resolver_endpoint_type == "IPV4"
    error_message = "resolver_endpoint_type のデフォルトが IPV4 であること"
  }
}

# --- resolver_endpoint_type に DUALSTACK を指定できること ---
run "dualstack_endpoint_type" {
  command = apply

  variables {
    direction              = "INBOUND"
    endpoint_name          = "test-dualstack"
    vpc_id                 = "vpc-12345678"
    subnet_ids             = ["subnet-aaaa", "subnet-bbbb"]
    allowed_cidr_blocks    = ["10.0.0.0/16"]
    resolver_endpoint_type = "DUALSTACK"
  }

  assert {
    condition     = aws_route53_resolver_endpoint.main.resolver_endpoint_type == "DUALSTACK"
    error_message = "resolver_endpoint_type が DUALSTACK であること"
  }
}
