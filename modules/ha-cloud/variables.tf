variable owner {
  description = "Name of project owner"
}

variable project {
  description = "Name of project"
}

variable dns_hostnames {
  description = "Enable/Disable dns hostnames support for vpc"
  default = false
}

variable ipv6_cidr {
  description = "Enable/Disable aws assigned ipv6 cidr ip"
  default = true
}

variable subnet_ipv6 {
  description = "Enable/Disable aws assigned ipv6 ip to subnets"
  default = false
}

variable dns_support {
  description = "Enable/Disable dns support for vpc"
  default = true
}

variable availability_zones {
  description = "Total number of availability zones to create resources in"
  default = 2
}

variable tags {
  description = "Tags all resources"
  default = {}
}

variable vpc_tenancy {
  description = "VPC instance tenancy setting"
  default = "default"
}

variable ssh_ips {
  description = "IP list for allowed ips for ec2 public ec2 instances"
  default = ["0.0.0.0/0"]
}

variable cidr {
  description = "Cidr IP address for the vpc"
  default = "10.0.0.0/16"
}

variable subnet_cidr_format {
  description = "Cidr IP address format for the subnets, the {index} will be replaced with subnet count"
  default = "10.0.{index}.0/24"
}
