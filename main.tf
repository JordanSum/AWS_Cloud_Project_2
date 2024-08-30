terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

module "ACM" {
  source = "./modules/acm"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.VPC.vpc_id_output
  aws_subnet_one = module.VPC.subnet_one
  aws_subnet_two = module.VPC.subnet_two
  cert = module.ACM.certificate_info
  IAM_Profile = module.IAM.IAM_Profile
  IGW = module.VPC.IGW
}

module "IAM" {
  source = "./modules/IAM"
}

module "VPC" {
  source = "./modules/VPC"
}

module "CodePipeline" {
  source = "./modules/CodePipeline"
  server1_tag_name = module.ec2.app_server1_name
  server2_tag_name = module.ec2.app_server2_name
}