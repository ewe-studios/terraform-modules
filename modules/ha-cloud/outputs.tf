output "public-internet-gatway" {
  value = aws_internet_gateway.HACloudInternetGatewayPublic
}

output "vpc" {
  value = aws_vpc.HACloudVPC
}

output "IAM" {
  value = module.IAM
}