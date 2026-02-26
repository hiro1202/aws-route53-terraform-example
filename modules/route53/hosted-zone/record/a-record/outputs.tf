output "fqdn" {
  description = "作成されたAレコードのFQDN"
  value       = aws_route53_record.a.fqdn
}
