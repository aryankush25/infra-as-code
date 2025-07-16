terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_vpc" "main" {
  cidr_block           = "192.168.1.0/25"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  
  tags = {
    Name = "iac-lab-aryan"
  }
}

# To get the VPC ID
# aws ec2 describe-vpcs --region ap-southeast-2 --filters Name=tag:Name,Values=iac-lab-aryan
