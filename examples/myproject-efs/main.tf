terraform {
  required_version = ">= 0.12"
}

locals {
  ssh_user = "ec2-user"
  efs_name="better_houses_efs"
  region="ap-southeast-1"
  project = "BetterHouse"
  project_bucket = "better-house-projects"
  ssh_key = "../../artefacts/terraform-kp.pem"
}

provider "aws" {
  region = local.region
}

module "IAM" {
  source = "../../modules/iam"
  prefix = local.project
  owner = local.project_bucket
}

module "S3Buckets" {
  force_destroy = true
  source = "../../modules/s3-upload-bucket"
  name = local.project_bucket
  owner = local.project_bucket
}

module "EC2S3IAM" {
  IAM = module.IAM
  source = "../../modules/ec2-s3-iam"
  owner = local.project
  prefix = local.project
  buckets = [module.S3Buckets.bucket.arn]
}

data "aws_vpc" "vpc" {
  id = "vpc-e3576784"
}

data "aws_subnet" "subnet" {
  id = "subnet-63f3233a"
}

resource "aws_security_group" "sg" {
  name = "efs_ec2_security_group"
  description = "Security group for EFS and ec"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all incoming traffic"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outgoing traffic"
  }
}

module "EFS" {
  source = "../../modules/efs-hyperdrive"
  subnet_id = data.aws_subnet.subnet.id
  security_groups = [aws_security_group.sg.id]
  owner = local.project_bucket
  name = local.efs_name
}

resource "aws_instance" "ec2_efs" {
  instance_type = "t2.micro"
  ami = "ami-0ec225b5e01ccb706"
  key_name = "terraform-kp"
  vpc_security_group_ids = [aws_security_group.sg.id]
  iam_instance_profile = module.IAM.EC2InstanceProfileRole.id

  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
      type = "ssh"
      user = local.ssh_user
      private_key = file(local.ssh_key)
      host = aws_instance.ec2_efs.public_ip
    }
  }

//  provisioner "local-exec" {
//    command = "ansible-playbook  -i '${aws_instance.ec2_efs.public_ip}', --private-key=${local.ssh_key} ./playbook/tfs-prepare.yml"
//    environment = {
//      arn = module.IAM.S3InstanceRole.arn
//      ANSIBLE_HOST_KEY_CHECKING = "False"
//    }
//  }
}

resource "null_resource" "ansible-playbook-runner" {
  depends_on = [aws_instance.ec2_efs]

  provisioner "local-exec" {
    command = "ansible-playbook -u=ec2-user -i '${aws_instance.ec2_efs.public_ip}', --private-key=${local.ssh_key} ./playbook/tfs-prepare.yml"
    environment = {
      arn = module.IAM.S3InstanceRole.arn
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }
  }
}

output "s3_bucket_arn" {
  value = module.IAM.S3InstanceRole.arn
}