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

variable region {
  default = "ap-southeast-1"
}

provider "aws" {
  region = var.region
}

output "ec2_policy" {
  value = module.EC2S3IAM.ec2_iam_instance_profile
}
