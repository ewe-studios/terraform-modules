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

module "EFS" {
  source = "./modules/efs-hyperdrive"

  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "ProjectS3" {
  source = "./modules/s3-upload-bucket"
  name = "project-bucket"

  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

provider "aws" {
  region = var.region
}
