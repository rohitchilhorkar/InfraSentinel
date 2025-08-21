# Create VPC
module "vpc"{
    source = "terraform-aws-modules/vpc/aws"
    version = "5.5.1"

    name = "${var.cluster-name}-vpc"
    cidr = "10.0.0.0/16"
    azs = ["${var.region}a","${var.region}b"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

    # configures the module to provision a single, 
    # shared NAT Gateway across all private subnets within the VPC.
    enable_nat_gateway = true
    single_nat_gateway = true
}

# Creating EKS cluster
module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "20.8.5"

    cluster_name = "${var.cluster-name}"
    cluster_version = "1.30"

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets 

    eks_managed_node_groups = {
        default = {
            desired_size = var.node_group_size
            max_size = 3
            min_size = 1

            instance_type = ["t3.medium"]
        }
    }
}