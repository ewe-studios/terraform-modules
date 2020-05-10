terraform {
  required_version = ">= 0.12"
}

resource "aws_efs_file_system" "hyperdrive" {
  kms_key_id = var.kms
  creation_token = var.name
  throughput_mode = var.throughput
  performance_mode = var.performance
  encrypted = var.kms != "" ? true : false 
  provisioned_throughput_in_mibps = var.throughput_mibps

  tags = merge(var.tags, { Owner = var.owner, Name = var.name })

  lifecycle_policy {
    transition_to_ia = var.lifePolicy
  }
}

resource "aws_efs_mount_target" "hyperdrive_mount" {
  file_system_id = aws_efs_file_system.hyperdrive.id
  security_groups = var.security_groups
  subnet_id = var.subnet_id
  ip_address = var.ip_address
}
