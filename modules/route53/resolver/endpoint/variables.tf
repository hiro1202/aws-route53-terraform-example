variable "direction" {
  type        = string
  description = "エンドポイントの方向。INBOUND または OUTBOUND を指定する。"

  validation {
    condition     = var.direction == "INBOUND" || var.direction == "OUTBOUND"
    error_message = "direction は INBOUND または OUTBOUND のいずれかを指定してください。"
  }
}

variable "endpoint_name" {
  type        = string
  description = "Resolverエンドポイントの名前"
}

variable "vpc_id" {
  type        = string
  description = "エンドポイントを配置するVPCのID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "エンドポイントのENIを配置するサブネットIDのリスト。最低2つ必要。"

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids には最低 2 つのサブネット ID を指定してください。"
  }
}

variable "ip_addresses" {
  type        = list(string)
  description = "エンドポイントに割り当てるIPアドレスのリスト。空の場合はAWSが自動割り当て。subnet_idsと同じ要素数が必要。"
  default     = []

  validation {
    condition     = length(var.ip_addresses) == 0 || length(var.ip_addresses) == length(var.subnet_ids)
    error_message = "ip_addresses は空配列か、subnet_ids と同じ要素数を指定してください。"
  }
}

variable "resolver_endpoint_type" {
  type        = string
  description = "エンドポイントのIPアドレスタイプ。IPV4、IPV6、DUALSTACK のいずれかを指定する。"
  default     = "IPV4"

  validation {
    condition     = contains(["IPV4", "IPV6", "DUALSTACK"], var.resolver_endpoint_type)
    error_message = "resolver_endpoint_type は IPV4, IPV6, DUALSTACK のいずれかを指定してください。"
  }
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "エンドポイントへのアクセスを許可するCIDRブロックのリスト。最低1つ必要。"

  validation {
    condition     = length(var.allowed_cidr_blocks) > 0
    error_message = "allowed_cidr_blocks には最低 1 つの CIDR ブロックを指定してください。"
  }
}
