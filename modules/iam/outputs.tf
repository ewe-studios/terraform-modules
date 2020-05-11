output "EC2InstanceProfile" {
  value = aws_iam_instance_profile.EC2InstanceProfile
}

output "EC2ImplicitRole" {
  value = aws_iam_role.EC2ImplicitRole
}

output "EC2AndAutoScalingImplicitRole" {
  value = aws_iam_role.EC2AndAutoScalingImplicitRole
}

output "S3ImplicitRole" {
  value = aws_iam_role.S3ImplicitRole
}

