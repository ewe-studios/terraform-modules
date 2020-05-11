
output "iam" {
  value = module.IAM
}

output "ec2_iam_instance_profile" {
  value = module.IAM.EC2InstanceProfile
}

output "ec2_iam_role" {
  value = module.IAM.EC2ImplicitRole
}

output "s3_iam_role" {
  value = module.IAM.S3ImplicitRole
}

output "s3_iam_role_policy_arn" {
  value = aws_iam_policy.S3ReadWriteListPolicy
}
