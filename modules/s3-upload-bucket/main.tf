terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "bucket_access_logs" {
  bucket = "${var.name}-access-logs"
  acl    = "log-delivery-write"
  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    Name  = "${var.name}_access_logs"
    Owner = var.owner
  })
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.name
  acl    = var.acl_name
  force_destroy = var.force_destroy

  versioning {
    enabled = var.versions
  }

  logging {
    target_bucket = aws_s3_bucket.bucket_access_logs.id
    target_prefix = "log/"
  }

  tags = merge(var.tags, {
    Name  = var.name
    Owner = var.owner
  })
}
