terraform {
  required_version = ">= 0.12"
}

# resource "aws_s3_bucket" "bucket_access_logs" {
#   bucket = "${var.name}-access-logs"
#   acl    = "log-delivery-write"
#   force_destroy = var.force_destroy

#   tags = merge(var.tags, {
#     Name  = "${var.name}_access_logs"
#     Owner = var.owner
#   })
# }

