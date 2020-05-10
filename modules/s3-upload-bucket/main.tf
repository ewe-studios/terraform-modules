terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "bucket_access_logs" {
  bucket = "${var.name}-access-logs"
  acl    = "log-delivery-write"

  tags = merge(var.tags, {
    Name  = "${var.name}_access_logs"
    Owner = var.owner
  })
}

locals {
  zipped = "zip -r ${var.name}.zip ${var.dir} && aws s3 cp ${var.name}.zip s3://${var.name}"
  unzipped = "aws s3 cp ${var.dir} s3://${var.name}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.name
  acl    = var.acl_name

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

  provisioner "local-exec" {
    command = var.zipped ? local.zipped : local.unzipped 
  }
}
