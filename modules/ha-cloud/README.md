# Terraform Modules: HA Cloud
Module will setup a highly available VPC, Security Groups, Internet Gateway setup necessary to have atleast
2 availability zones ready for use, with both a public and private zones.

Output for Module will return both VPC, Subnets, Internet Gatway, Load Balancer setup and Security groups necessary
for use.

## Usage

``` terraform
module "dbVPC" {
  source = "github.com/influx6/terraform-modules/modules/ha-vpc?ref=v0.0.5"

  name = "db-education-vpc"
  
  zones_count = 3

  # tags defines other custom tags we wish to add to IAM roles and policies.
  tags = {
    school = "Wendel"
  }
}
```
