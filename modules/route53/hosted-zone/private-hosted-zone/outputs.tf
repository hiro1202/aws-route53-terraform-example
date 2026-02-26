output "name" {
  description = "プライベートホストゾーンのドメイン名"
  value       = aws_route53_zone.private.name
}

output "zone_id" {
  description = "プライベートホストゾーンのID"
  value       = aws_route53_zone.private.zone_id
}

output "name_servers" {
  description = "プライベートホストゾーンのネームサーバーのリスト"
  value       = aws_route53_zone.private.name_servers
}
