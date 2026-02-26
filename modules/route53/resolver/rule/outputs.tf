output "rule_id" {
  description = "作成されたResolverルールのID"
  value       = aws_route53_resolver_rule.main.id
}

output "rule_arn" {
  description = "作成されたResolverルールのARN"
  value       = aws_route53_resolver_rule.main.arn
}
