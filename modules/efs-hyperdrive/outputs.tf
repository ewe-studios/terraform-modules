output "mount" {
  value = aws_efs_mount_target.hyperdrive_mount
}

output "efs" {
  value = aws_efs_file_system.hyperdrive
}
