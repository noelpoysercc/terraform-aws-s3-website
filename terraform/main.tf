provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.12"
}

provider "random" {}

resource "random_string" "random" {
  length    = 8
  special   = false
  min_lower = 8
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "vanguard-test-website-${random_string.random.result}"
  acl    = "public-read"

  policy = <<EOF
{
  "Id": "MakePublic",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::vanguard-test-website-${random_string.random.result}/*",
      "Principal": "*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
