data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_security_group" "ec2_sg" {
  id = var.security_group_id
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

