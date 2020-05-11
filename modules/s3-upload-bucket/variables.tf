variable owner {
  description = "Name of project owner"
  default = "mad-dev"
}

variable force_destroy {
  description = "Force the destruction of objects for bucket"
  default = false
}

variable versions {
  description = "Enabled/Disable versioning for bucket"
  default = false
}

variable acl_name {
  description = "Name of ACL policy for s3 bucket"
  default = "private"
}

variable tags {
  description = "Tags all resources"
  default = {}
}

variable name {
  description = "Name of S3 bucket"
  default = "mad-devs-bucket"
}
