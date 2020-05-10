variable owner {
  description = "Name of IAM project owner"
  default = "mad-dev"
}

variable zipped {
  description = "Upload directory as zip file"
  default = true
}

variable versions {
  description = "Enabled/Disable versioning for bucket"
  default = true
}

variable acl_name {
  description = "Name of ACL policy for s3 bucket"
  default = "private"
}

variable tags {
  description = "Tags for IAM and policies"
  default = {}
}

variable dir {
  description = "Directory path to be uploaded to bucket"
  default = "./examples"
}

variable name {
  description = "Name of S3 bucket"
  default = "mad-devs-bucket"
}
