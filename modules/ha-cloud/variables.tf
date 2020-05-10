variable owner {
  description = "Name of IAM project owner"
  default = "mad-dev"
}

variable availability_zones {
  description = "Total number of availability zones to create resources in"
  default = 2
}

variable tags {
  description = "Tags for IAM and policies"
  default = {}
}

variable name {
  description = "Name prefix for all created resources"
  default = "mad-devs"
}
