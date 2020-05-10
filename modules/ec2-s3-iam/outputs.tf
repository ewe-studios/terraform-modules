output "ec2_iam_instance_profile" {
  value = aws_iam_instance_profile.EC2InstanceIAMProfile
}

output "ec2_iam_role" {
  value = aws_iam_role.AWSEC2ImplicitRole
}

output "s3_iam_role" {
  value = aws_iam_role.S3ReadWriteListRole
}

output "s3_iam_role_policy_arn" {
  value = aws_iam_policy.S3ReadWriteListPolicy
}
