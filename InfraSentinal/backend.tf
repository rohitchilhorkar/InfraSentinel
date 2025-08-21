terraform {

# bucket = "${var.cluster_name}-state"
# Can't use dynamic reference, local, data sources
# This limitation exists because the backend needs to be
# evaluated before any other blocks, and using variables
# could create unresolvable or circular dependencies.

# <-- Before terraform init -->
# S3 bucket: must exist
# DynamoDB table: must exist (if used for locking)
# S3 key: does not need to exist; Terraform will create it

  backend "s3"{
    bucket = "InfraSentinel-state"
    key    = "InfraSentinel.tfstate"
    region = "us-east-2"
    dynamodb_table = "InfraSentinel-lock"
    encrypt = true
  }
}