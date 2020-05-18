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

resource "aws_iam_policy_attachment" "S3ReadWriteListRoleAttachment" {
  name = "S3ReadWriteListRoleAttachment"
  roles = [var.IAM.S3InstanceRole.name]
  policy_arn = aws_iam_policy.S3ReadWriteListPolicy.arn
}

data "aws_iam_policy_document" "STSAssumePolicy" {
  statement {
    sid = ""
    effect = "Allow"
    resources = [var.IAM.S3InstanceRole.arn]
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
  roles = [var.IAM.EC2InstanceRole.name]
  policy_arn = aws_iam_policy.STSS3RoleAssume.arn
}
