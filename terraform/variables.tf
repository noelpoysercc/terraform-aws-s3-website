variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}

variable "aws_secret_key" {}
variable "aws_access_key" {}
