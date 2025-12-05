terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# If user supplies ami_id, use it; otherwise find the most recent Amazon Linux 2023 AMI
# The aws_ami data source requires ec2:DescribeImages permission (usually available).
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-kernel-default-*", "al2023-ami-*", "amzn-ami-al2023-*"]
  }
}

locals {
  ami_to_use = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2023.id
}

resource "aws_instance" "demo" {
  ami           = local.ami_to_use
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  # Ensure a public IP on default VPC subnets
  associate_public_ip_address = true
}
