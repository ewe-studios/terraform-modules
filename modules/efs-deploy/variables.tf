variable owner {
  description = "Name of project owner"
  default = "mad-dev"
}

variable name {
  description = "Name of EFS hyperdrive"
  default = "mad-dev-efs"
}

variable tags {
  description = "Tags for EFS"
  default = {}
}

variable efs_id {
  description = "EFS ID for the EFS to be used"
  default = ""
}


