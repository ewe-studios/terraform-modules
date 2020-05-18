variable owner {
  description = "Name of project owner"
  default = "mad-dev"
}

variable IAM {
  description = "Attached IAM module policies from influx6/terraform-modules/modules/iam"
}

variable prefix {
  description = "Prefix to make these IAM roles and policies unique"
}

variable tags {
  description = "Tags all resources"
  default = {}
}

variable buckets {
  type = list(string)
  description = "S3 buckets to allow access to"
  default = ["db-bucket"]
}
