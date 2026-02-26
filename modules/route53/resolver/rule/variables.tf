variable "rule_name" {
  type        = string
  description = "Resolverルールの名前"
}

variable "domain_name" {
  type        = string
  description = "転送対象のドメイン名"
}

variable "rule_type" {
  type        = string
  description = "ルールのタイプ。FORWARD または SYSTEM を指定する。"
}

variable "target_ips" {
  type        = list(string)
  description = "DNSクエリの転送先IPアドレスのリスト"
}

variable "outbound_endpoint_id" {
  type        = string
  description = "クエリの転送に使用するOUTBOUND Resolverエンドポイントのの ID"
}
