variable "direction" {
  type = string

  validation {
    condition     = var.direction == "INBOUND" || var.direction == "OUTBOUND"
    error_message = "The direction variable must be either 'INBOUND' or 'OUTBOUND'."
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
    error_message = "The subnet_ids variable must contain at least 2 subnet IDs."
  }
}

variable "ip_addresses" {
  type    = list(string)
  default = []

  validation {
    condition     = length(var.ip_addresses) == 0 || length(var.ip_addresses) == length(var.subnet_ids)
    error_message = "The ip_addresses variable must be empty or match the number of subnet_ids."
  }
}

variable "allowed_cidr_blocks" {
  type = list(string)

  validation {
    condition     = length(var.allowed_cidr_blocks) > 0
    error_message = "The allowed_cidr_blocks variable must contain at least 1 CIDR block."
  }
}
