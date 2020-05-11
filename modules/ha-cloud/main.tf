terraform {
  required_version = ">= 0.12"
}

data "aws_availability_zones" "availability_zones" {}

module "IAM" {
  source = "../iam"

  owner = var.owner
  namePrefix = var.project
  tags = var.tags
}

resource "aws_vpc" "HACloudVPC" {
   cidr_block  = var.cidr
   instance_tenancy = var.vpc_tenancy
   enable_dns_support = var.dns_support
   enable_dns_hostnames = var.dns_hostnames
   assign_generated_ipv6_cidr_block = var.ipv6_cidr

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudVPC"
  })
}

resource "aws_internet_gateway" "HACloudInternetGatewayPublic" {
  vpc_id = aws_vpc.HACloudVPC.id

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudInternetGatewayPublic"
  })
}

resource "aws_subnet" "HACloudSubnetPrivate" {
  count = var.availability_zones

  vpc_id = aws_vpc.HACloudVPC.id
  map_public_ip_on_launch = false
  assign_ipv6_address_on_creation = var.subnet_ipv6
  cidr_block = replace(var.subnet_cidr_format, "{index}", count.index)
  availability_zone = element(data.aws_availability_zones.availability_zones.names, count.index)

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudSubnetPrivate_${count.index}"
  })
}

resource "aws_subnet" "HACloudSubnetPublic" {
  count = var.availability_zones

  vpc_id = aws_vpc.HACloudVPC.id
  map_public_ip_on_launch = true
  assign_ipv6_address_on_creation = var.subnet_ipv6
  cidr_block = replace(var.subnet_cidr_format, "{index}", var.availability_zones + count.index)
  availability_zone = element(data.aws_availability_zones.availability_zones.names, count.index)

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudSubnetPublic_${var.availability_zones + count.index}"
  })
}

resource "aws_eip" "HACloudSubnetPublicEIP" {
  vpc = true
}

resource "aws_nat_gateway" "HACloudNATGatewayForPrivate" {
  count = var.availability_zones
  allocation_id = aws_eip.HACloudSubnetPublicEIP.id
  subnet_id = element(aws_subnet.HACloudSubnetPublic, count.index).id

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudNATGatewayForPrivate_${count.index}"
  })

  depends_on = [aws_internet_gateway.HACloudInternetGatewayPublic, aws_eip.HACloudSubnetPublicEIP]
}

resource "aws_route_table" "HACloudPrivateTable" {
  vpc_id      = aws_vpc.HACloudVPC.id

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudPrivateTable"
  })
}

resource "aws_route" "HACloudPrivateTableToInternetRoute" {
  count = var.availability_zones
  route_table_id = aws_route_table.HACloudPrivateTable.id
  nat_gateway_id = element(aws_nat_gateway.HACloudNATGatewayForPrivate, count.index).id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private-subnet-association" {
  count = var.availability_zones
  route_table_id = aws_route_table.HACloudPrivateTable.id
  subnet_id = element(aws_subnet.HACloudSubnetPrivate, count.index).id
}

resource "aws_route_table" "HACloudPublicTable" {
  vpc_id      = aws_vpc.HACloudVPC.id

  tags = merge(var.tags, {
    Owner = var.owner
    Name = "HACloudPublicTable"
  })
}

resource "aws_route" "HACloudPublicInternetGateway" {
  route_table_id = aws_route_table.HACloudPublicTable.id
  gateway_id = aws_internet_gateway.HACloudInternetGatewayPublic.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public-subnet-association" {
  count = var.availability_zones
  route_table_id = aws_route_table.HACloudPublicTable.id
  subnet_id = element(aws_subnet.HACloudSubnetPublic, count.index).id
}

resource "aws_security_group" "HAEC2PublicSecurityGroup" {
  name = "HAEC2PublicSecurityGroup"
  description = "Security group for ec2 instances in public subnets"
  vpc_id      = aws_vpc.HACloudVPC.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "ssh"
    cidr_blocks = var.ssh_ips
    description = "Allow port 22 request into security group for specified ssh ips"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 443 request into security group"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 80 request into security group"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all internet requests from security group to go out"
  }
}

resource "aws_security_group" "HAEC2PrivateSecurityGroup" {
  name = "HAEC2PrivateSecurityGroup"
  description = "Security group for ec2 instances in private subnets"
  vpc_id      = aws_vpc.HACloudVPC.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [aws_security_group.HAEC2PublicSecurityGroup.id]
    description = "Allow public security group access to this security group"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow in health checks for instances uses these security groups"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all internet requests from security group to go out"
  }
}

resource "aws_security_group" "HAPublicELBSecurityGroup" {
  name = "HAPublicELBSecurityGroup"
  description = "Security group for ELB instances in public subnets"
  vpc_id      = aws_vpc.HACloudVPC.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outgoing traffic"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all incoming traffic"
  }
}
