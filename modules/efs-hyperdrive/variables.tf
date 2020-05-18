variable owner {
  description = "Name of project owner"
}

variable name {
  description = "Name of EFS hyperdrive"
}

variable kms {
  description = "KMS key to use for encryption of EFS hyperdrive content"
  default = ""
}

variable performance {
  description = "peroformance for EFS hyperdrive content"
  default = "generalPurpose"
}

variable throughput {
  description = "throughput EFS hyperdrive content"
  default = "bursting"
}

variable throughput_mibps {
  description = "throughput mib/s value for EFS hyperdrive content"
  default = 0
}

variable lifePolicy {
  description = "Lifecycle policy for EFS at which point a file not frequently access into set into a infrequency access storage: AFTER_7_DAYS | AFTER_14_DAYS | AFTER_30_DAYS | AFTER_60_DAYS | AFTER_90_DAYS"
  default = "AFTER_90_DAYS"
}

variable tags {
  description = "Tags for EFS"
  default = {}
}

variable security_groups {
  description = "Mount point security groups"
  default = []
}

variable subnet_id {
  type = string
  description = "subnet id to be used by efs mount point"
  default = "subnet_id"
}

variable ip_address {
  type = string
  description = "ip address to use for mounting efs with within subnet"
  default = ""
}

