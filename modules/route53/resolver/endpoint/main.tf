resource "aws_route53_resolver_endpoint" "main" {
  name                   = var.endpoint_name
  direction              = var.direction
  resolver_endpoint_type = var.resolver_endpoint_type

  security_group_ids = [
    aws_security_group.main.id,
  ]

  dynamic "ip_address" {
    for_each = range(length(var.subnet_ids))
    content {
      subnet_id = var.subnet_ids[ip_address.value]
      ip        = try(var.ip_addresses[ip_address.value], null)
    }
  }
}
