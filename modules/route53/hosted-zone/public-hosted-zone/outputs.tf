output "name" {
  description = "パブリックホストゾーンのドメイン名"
  value       = aws_route53_zone.public.name
}

output "zone_id" {
  description = "パブリックホストゾーンのID"
  value       = aws_route53_zone.public.zone_id
}

output "name_servers" {
  description = "パブリックホストゾーンのネームサーバーのリスト"
  value       = aws_route53_zone.public.name_servers
}
