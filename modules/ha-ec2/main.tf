terraform {
  required_version = ">= 0.12"
}

module "Infrastructure" {
  source = "../ha-cloud"
  availability_zones = var.availability_zones
  ec2_keypair_name = var.ec2_keypair_name

  project = var.project
  owner = var.owner
  tags = var.tags
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

