terraform {
  required_version = ">= 0.12"
}

locals {
  S3Name = "${var.namePrefix}-S3ImplicitRole"
  EC2Name = "${var.namePrefix}-EC2ImplicitRole"
  EC2InstanceName = "${var.namePrefix}-EC2InstanceProfile"
  EC2AndAutoScalingName = "${var.namePrefix}-EC2AndAutoScalingImplicitRole"
  ec2Principals = distinct(concat(["ec2.amazonaws.com"], var.ec2_principals))
  s3Principals = distinct(concat(["s3.amazonaws.com"], var.s3_principals))
  ec2AutoScalingPrincipals = distinct(concat(["ec2.amazonaws.com", "application-autoscaling.amazonaws.com"], var.ec2_principals))
}

data "aws_iam_policy_document" "S3ImplicitPolicyDocument" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = local.s3Principals
    }
    actions = [
        "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "S3ImplicitRole" {
  name = local.S3Name
  force_detach_policies = true

  # this is used to define the trust policy for the 
  # service this role is to apply to, always include.
  assume_role_policy = data.aws_iam_policy_document.S3ImplicitPolicyDocument.json

  tags = merge(var.tags, { Owner = var.owner })
}

data "aws_iam_policy_document" "EC2ImplicitPolicyDocument" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = local.ec2Principals
    }
    actions = [
        "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "EC2ImplicitRole" {
  name = local.EC2Name
  force_detach_policies = true
  
  # this is used to define the trust policy for the 
  # service this role is to apply to, always include.
  assume_role_policy = data.aws_iam_policy_document.EC2ImplicitPolicyDocument.json

  tags = merge(var.tags, { Owner = var.owner })
}

data "aws_iam_policy_document" "EC2AndAutoScalingImplicitPolicyDocument" {
  statement {
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = local.ec2AutoScalingPrincipals
    }
    actions = [
        "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "EC2AndAutoScalingImplicitRole" {
  name = local.EC2AndAutoScalingName
  force_detach_policies = true
  
  # this is used to define the trust policy for the 
  # service this role is to apply to, always include.
  assume_role_policy = data.aws_iam_policy_document.EC2AndAutoScalingImplicitPolicyDocument.json

  tags = merge(var.tags, { Owner = var.owner })
}

resource "aws_iam_instance_profile" "EC2InstanceProfile" {
  name = local.EC2InstanceName
  role = aws_iam_role.EC2ImplicitRole.name
}
