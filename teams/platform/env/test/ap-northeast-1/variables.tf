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

variable "env" {
  type = string
}
