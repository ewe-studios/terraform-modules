
output "IAM" {
  value = module.IAM
}

output "s3_iam_role_policy_arn" {
  value = aws_iam_policy.S3ReadWriteListPolicy
}
