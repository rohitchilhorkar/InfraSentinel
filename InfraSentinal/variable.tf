variable "region" {
    default  = "us-east-2"
}

variable "cluster-name" {
    default  = "InfraSentinel"
}

variable "node_group_size"{
    default  = 2
}
variable "dynamodb_table_name"{
    default  = "InfraSentinel-lock"
}
variable "s3_key_name"{
    default  = "InfraSentinel.tfstate"
}
