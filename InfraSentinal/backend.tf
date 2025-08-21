terraform {

# bucket = "${var.cluster_name}-state"
# Can't use dynamic reference, local, data sources
# This limitation exists because the backend needs to be
# evaluated before any other blocks, and using variables
# could create unresolvable or circular dependencies.

# <-- Before terraform init -->
# S3 bucket: must exist - can't use uppercase chars
# DynamoDB table: must exist (if used for locking) - partition key state_lock_id
# Terraform requires a DynamoDB table with a partition key (HASH key) called LockID of type String. 
# S3 key: does not need to exist; Terraform will create it

  backend "s3"{
    bucket = "infrasentinal-state-bucket"
    key    = "infrasentinal.tfstate"
    region = "us-east-2"
    dynamodb_table = "infrasentinal-lock"
    encrypt = true
  }
}