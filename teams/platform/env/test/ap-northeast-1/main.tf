module "network" {
  source = "github.com/hirokazufunaki/terraform-aws-network?ref=87d858e703d4f911c52c6a102674dd135d921924" # v1.0.0

  name            = "platform"
  vpc_cidr        = "10.0.0.0/16"
  private_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
}

module "resolver_endpoint" {
  source = "../../../../../modules/route53/resolver/endpoint"

  direction           = "INBOUND"
  endpoint_name       = "example"
  vpc_id              = module.network.vpc_id
  subnet_ids          = module.network.private_subnet_ids
  allowed_cidr_blocks = ["10.0.0.0/16"]
}

module "resolver_outbound_endpoint" {
  source = "../../../../../modules/route53/resolver/endpoint"

  direction           = "OUTBOUND"
  endpoint_name       = "example-outbound"
  vpc_id              = module.network.vpc_id
  subnet_ids          = module.network.private_subnet_ids
  allowed_cidr_blocks = ["10.0.0.0/16"]
}

module "resolver_rule" {
  source = "../../../../../modules/route53/resolver/rule"

  rule_name            = "example"
  rule_type            = "FORWARD"
  domain_name          = "example.com"
  target_ips           = ["192.168.1.1", "192.168.1.2"]
  outbound_endpoint_id = module.resolver_outbound_endpoint.endpoint_id
}
