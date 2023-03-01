# configures the AWS provider

provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}

/*
configures a Virtual Private Cloud (VPC) module, which provisions networking resources
such as a VPC, subnets, and internet and NAT gateways based on the arguments provided.
*/
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

#  defines three EC2 instances provisioned within the VPC created by the module.

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  count = 3
  name  = "my-ec2-cluster-${count.index}"

  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"
  key_name                = "user1"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}