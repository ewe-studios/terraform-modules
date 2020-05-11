output "EC2InstanceProfileRole" {
  value = aws_iam_instance_profile.EC2InstanceProfile
}

output "EC2InstanceRole" {
  value = aws_iam_role.EC2ImplicitRole
}

output "EC2AndAutoScalingImplicitRole" {
  value = aws_iam_role.EC2AndAutoScalingImplicitRole
}

output "EC2AutoScalingCloudWatchLogsRole" {
  value = aws_iam_role.EC2AutoScalingCloudWatchLogs
}

output "EC2ELBCloudWatchAndLogsPolicy" {
  value = aws_iam_role_policy.EC2ELBCloudWatchAndLogsPolicy
}

output "S3InstanceRole" {
  value = aws_iam_role.S3ImplicitRole
}

