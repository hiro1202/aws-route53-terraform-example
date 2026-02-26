output "fqdn" {
  description = "作成されたエイリアスレコードのFQDN"
  value       = aws_route53_record.alias.fqdn
}
