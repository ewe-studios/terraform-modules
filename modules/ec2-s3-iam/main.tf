terraform {
  required_version = ">= 0.12"
}

data "aws_iam_policy_document" "S3ActionPolicyDocument" {
  statement {
    sid = ""
    effect = "Allow"
    resources = ["*"]
    actions = [
        "s3:ListAllMyBuckets",
    ]
  }

  statement {
    sid = ""
    effect = "Allow"
    resources = var.buckets
    actions = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucketVersions",
        "s3:GetObjectTagging",
        "s3:ListBucket",
        "s3:PutObjectTagging",
        "s3:GetObjectVersion"
    ]
  }
}

resource "aws_iam_policy" "S3ReadWriteListPolicy" {
  name = "S3ReadWriteListPolicy"
  policy = data.aws_iam_policy_document.S3ActionPolicyDocument.json
}

resource "aws_iam_role" "S3ReadWriteListRole" {
  name = "S3ReadWriteListRole"
  force_detach_policies = true

  # this is used to define the trust policy for the 
  # service this role is to apply to, always include.
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF

  tags = merge(var.tags, { Owner = var.owner })
}

resource "aws_iam_policy_attachment" "S3ReadWriteListRoleAttachment" {
  name = "S3ReadWriteListRoleAttachment"
  roles = [aws_iam_role.S3ReadWriteListRole.name]
  policy_arn = aws_iam_policy.S3ReadWriteListPolicy.arn
}

resource "aws_iam_role" "AWSEC2ImplicitRole" {
  name = "AWSEC2ImplicitRole"
  force_detach_policies = true
  
  # this is used to define the trust policy for the 
  # service this role is to apply to, always include.
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF

  tags = merge(var.tags, { Owner = var.owner })
}

data "aws_iam_policy_document" "STSAssumePolicy" {
  statement {
    sid = ""
    effect = "Allow"
    resources = [aws_iam_role.S3ReadWriteListRole.arn]
    actions = [
        "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_policy" "STSS3RoleAssume" {
  name = "STSS3RoleAssume"
  policy = data.aws_iam_policy_document.STSAssumePolicy.json
}

resource "aws_iam_policy_attachment" "STSAssumeRoleAttachment" {
  name = "STSAssumeRoleAttachment"
  roles = [aws_iam_role.AWSEC2ImplicitRole.name]
  policy_arn = aws_iam_policy.STSS3RoleAssume.arn
}

resource "aws_iam_instance_profile" "EC2InstanceIAMProfile" {
  name = "EC2InstanceIAMProfile"
  role = aws_iam_role.AWSEC2ImplicitRole.name
}
