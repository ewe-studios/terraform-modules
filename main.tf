terraform {
  required_version = ">= 0.12"
}

module "IAMPolicies" {
  source = "./modules/iam"

  owner = "Better Macs"
  prefix = "BetterMacs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "EC2S3IAM" {
  IAM = module.IAMPolicies
  source = "./modules/ec2-s3-iam"

  owner = "Better Macs"
  prefix = "BetterMacs"
  buckets = ["*"]
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "EFS" {
  name = "efs_hyperdrive"
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

module "HACloud" {
  source = "./modules/ha-cloud"
  availability_zones = 4
  ec2_keypair_name = "WOLS"

  project = "BetterMacSystem"
  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

module "HAEC2" {
  source = "./modules/ha-ec2"
  availability_zones = 4
  ec2_keypair_name = "WOLS"

  project = "BetterMacSystem"
  owner = "Better Macs"
  tags = {
    Region = "Lagos/Nigeria"
  }
}

provider "aws" {
  region = var.region
}
