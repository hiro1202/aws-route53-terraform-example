output "endpoint_id" {
  description = "作成されたResolverエンドポイントのID"
  value       = aws_route53_resolver_endpoint.main.id
}
