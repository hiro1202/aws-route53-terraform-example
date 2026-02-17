# ------- AWS の基本設定 -------
variable "aws_profile" {
  type        = string
  description = "Terraform 実行時に使用するプロファイル名"
  default     = null
}

variable "aws_region" {
  type        = string
  description = "provider 設定で使用する AWS リージョン。DR 対応の場合を除き ap-northeast-1 を指定。"
  default     = "ap-northeast-1"
}

# ------- Terraform の基本設定 -------
variable "env" {
  type        = string
  description = "デプロイ先の環境名 (test, prod など)"
}

variable "prefix" {
  type = string
}

# ------- Route53 Resolver Endpoint -------
variable "resolver_endpoint_name" {
  type        = string
  description = "Route53 Resolver Endpoint の名前"
}

variable "resolver_endpoint_direction" {
  type        = string
  description = "Resolver Endpoint の方向 (INBOUND/OUTBOUND)"

  validation {
    condition     = var.resolver_endpoint_direction == "INBOUND" || var.resolver_endpoint_direction == "OUTBOUND"
    error_message = "resolver_endpoint_direction は INBOUND または OUTBOUND のいずれかを指定してください。"
  }
}

variable "resolver_endpoint_type" {
  type        = string
  description = "Resolver Endpoint のプロトコルタイプ (IPV4, IPV6, DUALSTACK)"

  validation {
    condition     = contains(["IPV4", "IPV6", "DUALSTACK"], var.resolver_endpoint_type)
    error_message = "resolver_endpoint_type は IPV4, IPV6, DUALSTACK のいずれかを指定してください。"
  }
}

variable "resolver_endpoint_subnet_ids" {
  type        = list(string)
  description = "Resolver Endpoint を配置する subnet_id の配列"

  validation {
    condition     = length(var.resolver_endpoint_subnet_ids) >= 2
    error_message = "resolver_endpoint_subnet_ids には最低 2 つのサブネット ID を指定してください。"
  }
}

variable "resolver_endpoint_ip_addresses" {
  type        = list(string)
  description = "Resolver Endpoint に割り当てる固定 IP アドレスの配列。空配列の場合は AWS 側で自動割り当て。"
  default     = []

  validation {
    condition     = length(var.resolver_endpoint_ip_addresses) == 0 || length(var.resolver_endpoint_ip_addresses) == length(var.resolver_endpoint_subnet_ids)
    error_message = "resolver_endpoint_ip_addresses は空配列か、resolver_endpoint_subnet_ids と同じ要素数を指定してください。"
  }
}
