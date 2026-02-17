variable "direction" {
  type = string

  validation {
    condition     = var.direction == "INBOUND" || var.direction == "OUTBOUND"
    error_message = "direction は INBOUND または OUTBOUND のいずれかを指定してください。"
  }
}

variable "endpoint_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "subnet_ids には最低 2 つのサブネット ID を指定してください。"
  }
}

variable "ip_addresses" {
  type    = list(string)
  default = []

  validation {
    condition     = length(var.ip_addresses) == 0 || length(var.ip_addresses) == length(var.subnet_ids)
    error_message = "ip_addresses は空配列か、subnet_ids と同じ要素数を指定してください。"
  }
}

variable "resolver_endpoint_type" {
  type    = string
  default = "IPV4"

  validation {
    condition     = contains(["IPV4", "IPV6", "DUALSTACK"], var.resolver_endpoint_type)
    error_message = "resolver_endpoint_type は IPV4, IPV6, DUALSTACK のいずれかを指定してください。"
  }
}

variable "allowed_cidr_blocks" {
  type = list(string)

  validation {
    condition     = length(var.allowed_cidr_blocks) > 0
    error_message = "allowed_cidr_blocks には最低 1 つの CIDR ブロックを指定してください。"
  }
}
