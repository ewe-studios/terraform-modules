terraform {
  required_version = ">= 0.12"
}

module "EC2S3IAM" {
  source = "./modules/ec2-s3-iam"

  owner = "Better Systems"
  buckets = ["*"]
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "EFS" {
  source = "./modules/efs-hyperdrive"
  subnet_id = "subnet-63f3233a"
  security_groups = ["sg-5c231526"]

  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "ProjectS3" {
  source = "./modules/s3-upload-bucket"
  name = "project-bucket-34321342242423432"
  force_destroy = true

  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

provider "aws" {
  region = var.region
}
