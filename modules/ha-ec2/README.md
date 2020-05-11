# Terraform Modules: S3 Upload Bucket
Module will setup necessary an S3 Bucket and upload provided path as either a zip or as a whole directory into 
provided S3 bucket.

## Usage

``` terraform
module "dbEducationBucket" {
  source = "github.com/influx6/terraform-modules/modules/s3-upload-bucket?ref=v0.0.5"
  
  # owner defines custom tags we wish to add to IAM roles and policies.
  dir = "${path.ModulePath}/project"

  zipped = true

  # tags defines other custom tags we wish to add to IAM roles and policies.
  tags = {
    school = "Wendel"
  }

  # name of bucket
  name = "db-education"
}
```
