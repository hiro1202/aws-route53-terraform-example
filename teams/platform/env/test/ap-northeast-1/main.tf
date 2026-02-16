module "network" {
  source = "github.com/hirokazufunaki/terraform-aws-network?ref=v1.0.0"

  name            = "platform"
  vpc_cidr        = "10.0.0.0/16"
  private_subnets = ["10.0.0.0/24"]
}
