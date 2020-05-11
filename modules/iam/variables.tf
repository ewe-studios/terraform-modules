variable owner {
  description = "Name of project owner"
}

variable namePrefix {
  description = "Prefix to make IAM records unique in themselves"
}

variable tags {
  description = "Tags all resources"
  default = {}
}

variable ec2_principals {
  description = "Other principals we want in ec2 implicit roles"
  default = []
}

variable s3_principals {
  description = "Other principals we want in S3 implicit roles"
  default = []
}
