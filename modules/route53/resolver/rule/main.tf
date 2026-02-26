resource "aws_route53_resolver_rule" "main" {
  name                 = var.rule_name
  rule_type            = var.rule_type
  domain_name          = var.domain_name
  resolver_endpoint_id = var.outbound_endpoint_id

  dynamic "target_ip" {
    for_each = var.target_ips
    content {
      ip = target_ip.value
    }
  }
}
