resource "aws_security_group" "main" {
  name        = "${var.endpoint_name}-sg"
  description = "Security group for Route53 Resolver endpoint ${var.endpoint_name}"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "dns_tcp" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  ip_protocol       = "tcp"
  from_port         = 53
  to_port           = 53
  description       = "Allow DNS TCP from ${each.value}"
}

resource "aws_vpc_security_group_ingress_rule" "dns_udp" {
  for_each = toset(var.allowed_cidr_blocks)

  security_group_id = aws_security_group.main.id
  cidr_ipv4         = each.value
  ip_protocol       = "udp"
  from_port         = 53
  to_port           = 53
  description       = "Allow DNS UDP from ${each.value}"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "To anywhere."
}
