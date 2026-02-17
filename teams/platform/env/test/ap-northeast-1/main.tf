module "network" {
  source = "github.com/hirokazufunaki/terraform-aws-network?ref=v1.0.0"

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
