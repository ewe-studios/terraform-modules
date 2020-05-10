# Terraform Modules: EFS Hyperdrive
Module will setup EFS file system for use with other containers or EC2 instances.

## Usage

``` terraform
module "efs-hyperdrive" {
  source = "github.com/influx6/terraform-modules/modules/efs-hyperdrive?ref=v0.0.5"
  
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
