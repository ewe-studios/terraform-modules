terraform {
  required_version = ">= 0.12"
}

module "EC2S3IAM" {
  source = "./modules/ec2-s3-iam"

  owner = "Better Macs"
  buckets = ["*"]
  tags = {
    Region = "Lagos/Nigeria"
  }
}

provider "aws" {
  region = var.region
}
