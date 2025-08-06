resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# To get the VPC ID
# aws ec2 describe-vpcs --region ap-southeast-2 --filters Name=tag:Name,Values=aryan-iac-lab-vpc

# To create a VPC using CloudFormation
# aws cloudformation create-stack --stack-name iac-lab-cfn-yaml-aryan --template-body file://./cloudformation_template.yaml

# To delete a VPC using CloudFormation
# aws cloudformation delete-stack --stack-name iac-lab-cfn-yaml-aryan
