variable owner {
  description = "Name of IAM project owner"
  default = "mad-dev"
}

variable tags {
  description = "Tags for IAM and policies"
  default = {}
}

variable buckets {
  type = list(string)
  description = "S3 buckets to allow access to"
  default = ["db-bucket"]
}
