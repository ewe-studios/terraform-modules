# Terraform Modules: EC2-S3 IAM
Module will setup necessary IAM policies for creating a EC2 Instance policy which has access to assume an S3 Role which allows reading and writing to a
set of S3 Buckets.

## Usage

``` terraform
module "consul_cluster" {
  source = "github.com/influx6/terraform-modules/modules/ec2-s3-iam?ref=v0.0.5"
  
  # owner defines custom tags we wish to add to IAM roles and policies.
  owner = "db-education"

  # tags defines other custom tags we wish to add to IAM roles and policies.
  tags = {
    school = "Wendel"
  }

  # buckets is a list of bucket names which we want to generate IAM rules for.
  buckets = ["db-education", "dbs-education"]
}
```
