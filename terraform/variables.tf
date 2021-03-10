variable "bucket_name" {
	description = "The name of the S3 bucket to create, e.g. your-bucket-name"
}

variable "deployer_arns" {
  type        = "list"
  default     = []
  description = "(Optional) Array of deployer ARNs to grant `deployer` permissions"
}

variable duplicate_content_penalty_secret {
  description = "Secret/password used to restrict access to S3 to CloudFront"
}

#variable environment {
#  default = "default"
#  description = "The label for the environment. Used for naming/tagging purposes"
#}

variable "error_document" {
  default = "error.html"
}

variable "index_document" {
  default = "index.html"
}

variable region {
  description = "e.g. us-east-1"
}

# variable "aws_secret_key" {}
# variable "aws_access_key" {}
