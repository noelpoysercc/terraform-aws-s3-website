# Output variable definitions

output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "domain" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_domain
}

#output "url" {
#  description = "URL of the bucket"
#  value       = "${aws_s3_bucket.s3_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
#}

