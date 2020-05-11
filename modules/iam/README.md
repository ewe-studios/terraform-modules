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

## How To Assume Role

```bash

# Clean variables
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset ACCOUNT_ID

# Call for ACCOUNT_ID
curl -s http://169.254.169.254/latest/meta-data/identity-credentials/ec2/info | jq -r '.AccountId' | awk '{print "export", "ACCOUNT_ID="$0}' > variables

# Call for INSTANCE_ID
curl -s http://169.254.169.254/latest/meta-data/instance-id | awk '{print "export", "INSTANCE_ID="$0}' >> variables

# Read account ID variables into global
. ./variables

# Assume role
aws sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/{ROLE_NAME} --role-session-name "BuilderHostname=$INSTANCE_ID" > mysession.json

# Extract values from session, write to disk
jq -r '.Credentials.AccessKeyId' mysession.json | awk '{print "export", "AWS_ACCESS_KEY_ID="$0}' > variables
jq -r '.Credentials.SecretAccessKey' mysession.json | awk '{print "export", "AWS_SECRET_ACCESS_KEY="$0}' >> variables
jq -r '.Credentials.SessionToken' mysession.json | awk '{print "export", "AWS_SESSION_TOKEN="$0}' >> variables

# Read variables into global
. ./variables

# Delete variables file on disk
rm variables
```
