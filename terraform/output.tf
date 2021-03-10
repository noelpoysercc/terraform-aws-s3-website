output "s3_website_bucket_name" {
  value = "${aws_s3_bucket.website_bucket.id}"
}

output "s3_website_bucket_domain_name" {
  value = "${aws_s3_bucket.website_bucket.bucket_domain_name}"
}
