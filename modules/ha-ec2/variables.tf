variable owner {
  description = "Name of project owner"
  default = "mad-dev"
}

variable region {
  description = "Region of ec2 instances"
  default = "ap-southeast-1"
}

variable force_destroy {
  description = "Force the destruction of objects for bucket"
  default = false
}

variable tags {
  description = "Tags all resources"
  default = {}
}

variable name {
  description = "Name of project for ec2 instances"
  default = "mad-project"
}
