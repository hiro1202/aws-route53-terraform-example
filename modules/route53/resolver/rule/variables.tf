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
  description = "Resolver ルールのタイプ"

  validation {
    condition     = contains(["FORWARD", "SYSTEM", "RECURSIVE"], var.rule_type)
    error_message = "rule_type は FORWARD、SYSTEM、RECURSIVE のいずれかを指定してください。"
  }
}

variable "target_ips" {
  type        = list(string)
  description = "DNSクエリの転送先IPアドレスのリスト"
}

variable "outbound_endpoint_id" {
  type        = string
  description = "クエリの転送に使用するOUTBOUND Resolverエンドポイントのの ID"
}
