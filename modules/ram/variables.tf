variable "resource_share_name" {
  type        = string
  description = "RAMのリソース共有の名前"
}

variable "shared_resource_arn" {
  type        = string
  description = "共有するリソースのARN"
}

variable "target_account_id" {
  type        = string
  description = "共有先のアカウントID"
}
