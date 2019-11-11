resource "aws_s3_bucket" "private" {
  bucket = "private-pragmatic-terraform.jnsato.com"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "public" {
  bucket = "public-pragmatic-terraform.jnsato.com"
  acl    = "public-read"

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-pragmatic-terraform.jnsato.com"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}

locals {
  eu_central_1_alb_account_id = "054676820928"
}

data "aws_iam_policy_document" "alb_log" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]

    principals {
      type        = "AWS"
      identifiers = [local.eu_central_1_alb_account_id]
    }
  }
}

resource "aws_s3_bucket" "artifact" {
  bucket = "artifact-pragmatic-terraform.jnsato.com"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}

resource "aws_s3_bucket" "operation" {
  bucket = "operation-pragmatic-terraform.jnsato.com"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}
