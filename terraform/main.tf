provider "aws" {
}

terraform {
  required_version = ">= 0.12"
}

#module "website_s3_bucket" {
#  source = "./vanguard-test-website"

#  bucket_name = "<UNIQUE BUCKET NAME>"

#  tags = {
#    Terraform   = "true"
#    Environment = "dev"
#  }
#}

provider "random" {}

resource "random_string" "random" {
  length    = 8
  special   = false
  min_lower = 8
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${random_string.random.result}"

  force_destroy = true
  
  versioning {
    enabled = true                                                                                                                                                                                                                         
  }
  
  lifecycle {
    create_before_destroy = true
  }
  
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::aws_s3_bucket.s3_bucket.bucket/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.tags
}
