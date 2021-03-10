variable "create_bucket" {
  description = "Conditionally create S3 bucket"
  default     = true
}

variable "upload_files" {
  description = "Conditionally upload files"
  default     = true
}

variable "allow_public" {
  description = "Allow public read access to bucket"
  default     = false
}

variable "aws_secret_key" {}
variable "aws_access_key" {}
