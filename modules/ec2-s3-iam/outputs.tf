
output "S3-ReadWrite-ListPolicy" {
  value = aws_iam_policy.S3ReadWriteListPolicy
}

output "S3-STS-AssumeRole" {
  value = aws_iam_policy.STSS3RoleAssume
}