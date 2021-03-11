provider "aws" {
}

terraform {
  required_version = ">= 0.12"
}

provider "random" {}

# Create a random string
resource "random_id" "random_string" {
  byte_length = 5
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = format("%s-%d",var.bucket_name, random_id.random_string.dec)

  force_destroy = true
  
  versioning {
    enabled = true                                                                                                                                                                                                                         
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  acl    = "public-read"
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.tags
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "s3bucketPolicy",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3_bucket.id}/*"
            ]
        }
    ]
}
EOF
}
