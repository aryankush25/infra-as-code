# Data source to get availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# Public Subnets (2)
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = format("%s-public-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = format("%s-public-subnet-2", var.prefix)
  }
}

# Private Subnets (2)
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet3_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = format("%s-private-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet4_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = format("%s-private-subnet-2", var.prefix)
  }
}

# Secure Subnets (2)
resource "aws_subnet" "secure_subnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet5_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = format("%s-secure-subnet-1", var.prefix)
  }
}

resource "aws_subnet" "secure_subnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet6_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = format("%s-secure-subnet-2", var.prefix)
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-internet-gateway", var.prefix)
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = format("%s-nat-eip", var.prefix)
  }
}

# NAT Gateway
resource "aws_nat_gateway" "main_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = format("%s-nat-gateway", var.prefix)
  }

  depends_on = [aws_internet_gateway.main_igw]
}

# To get the VPC ID
# aws ec2 describe-vpcs --region ap-southeast-2 --filters Name=tag:Name,Values=aryan-iac-lab-vpc

# To create a VPC using CloudFormation
# aws cloudformation create-stack --stack-name iac-lab-cfn-yaml-aryan --template-body file://./cloudformation_template.yaml

# To delete a VPC using CloudFormation
# aws cloudformation delete-stack --stack-name iac-lab-cfn-yaml-aryan
