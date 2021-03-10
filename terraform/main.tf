provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "website_bucket" {
  acl       = "private"
  bucket    = "${var.bucket_name}"
  region    = "${var.region}"

  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }

  # tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.bucket_name}", "Environment", "${var.environment}", "Project", "${var.project}"))}"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = "${aws_s3_bucket.website_bucket.id}"
  policy = "${data.aws_iam_policy_document.website_policy.json}"
}

data "aws_iam_policy_document" "website_policy" {
  statement = [{
    actions   = ["s3:GetObject"]

    condition {
      test      = "StringEquals"
      variable  = "aws:UserAgent"
      values    = ["${var.duplicate_content_penalty_secret}"]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
  }]

  # Support deployer ARNs
  statement = ["${flatten(data.aws_iam_policy_document.deployer_policy.*.statement)}"]
}

data "aws_iam_policy_document" "deployer_policy" {
  count = "${length(var.deployer_arns)}"

  statement = [{
    actions   = ["s3:ListBucket"]

    principals {
      type        = "AWS"
      identifiers = ["${var.deployer_arns}"]
    }

    resources = ["${aws_s3_bucket.website_bucket.arn}"]
  },
  {
    actions   = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject"
    ]

    principals {
      type        = "AWS"
      identifiers = ["${var.deployer_arns}"]
    }

    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
  }]
}
