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

To mount EFS on EC2

```bash
#!/bin/bash

sleep 5m
sudo su - root

# Install AWS EFS Utilities
yum install -y amazon-efs-utils

# Mount EFS
mkdir /efs
mount -t efs ${efs_id}:/ /efs

# Edit fstab so EFS automatically loads on reboot
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab
```

Where `${efs_id}` is the FileSystemID of the EFS created.
