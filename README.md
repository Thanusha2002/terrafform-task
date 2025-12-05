# Terraform EC2 Simple Project

This canvas contains everything you asked for: the Terraform code files (`main.tf`, `variables.tf`, `outputs.tf`) plus a `README.md` you can use in the project root. Copy each file into your project folder and follow the run steps in the README.

---

## File: `main.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Choose AMI by platform using a data source (keeps the code up-to-date).
# Default is Amazon Linux 2. Set var.platform = "ubuntu" to use Ubuntu 22.04 LTS.

data "aws_ami" "selected" {
  most_recent = true

  filter {
    name   = "name"
    values = var.platform == "ubuntu" ? ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] : ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = var.platform == "ubuntu" ? ["099720109477"] : ["137112412989"]
}

resource "aws_security_group" "ssh" {
  name        = "terraform-allow-ssh"
  description = "Allow SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-allow-ssh"
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.selected.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = {
    Name = var.instance_name
  }
}
```

---

## File: `variables.tf`

```hcl
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
  default     = "terraform-ec2-sample"
}

variable "platform" {
  description = "AMI platform: \"amazon-linux\" (default) or \"ubuntu\""
  type        = string
  default     = "amazon-linux"
}

variable "key_name" {
  description = "Existing EC2 key pair name to enable SSH (required)"
  type        = string
  default     = ""
}
```

---

## File: `outputs.tf`

```hcl
output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP of the instance"
  value       = aws_instance.web.public_ip
}

output "availability_zone" {
  description = "Availability Zone of the instance"
  value       = aws_instance.web.availability_zone
}

output "ami_id" {
  description = "AMI ID used for the instance"
  value       = data.aws_ami.selected.id
}
```

---

## File: `README.md`

````md
# Terraform EC2 Simple Project

This project creates a single EC2 instance (Amazon Linux 2 by default) and outputs its Instance ID, Public IP, Availability Zone and AMI ID. It also creates a Security Group that allows SSH (TCP/22) from everywhere — **only use this for learning**.

## Files
- `main.tf` - main resources and data source
- `variables.tf` - variables and defaults
- `outputs.tf` - outputs to display after apply

## Defaults
- **Region:** `us-east-1`
- **Instance type:** `t2.micro`
- **Platform (AMI):** `amazon-linux` (set `platform = "ubuntu"` to use Ubuntu 22.04)
- **Instance name tag:** `terraform-ec2-sample`

> **Important:** Provide an existing EC2 Key Pair name in `var.key_name` so you can SSH into the instance. You can create a key pair in the AWS Console or with the AWS CLI: `aws ec2 create-key-pair --key-name mykey --query 'KeyMaterial' --output text > mykey.pem` (save securely, set permissions `chmod 400 mykey.pem`).

## Quick usage
1. Ensure AWS credentials are configured and working:
   ```bash
   aws sts get-caller-identity
````

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. (Optional) Preview what will be created:

   ```bash
   terraform plan -out plan.out
   ```

   *Take a screenshot of this command's stdout for your deliverable.*

4. Apply to create the instance:

   ```bash
   terraform apply -auto-approve

   *Take a screenshot showing the "Apply complete!" output.*

5. After apply completes, run:

   ```bash
   terraform output
   ```
   The outputs will include `instance_id`, `public_ip`, `availability_zone`, and `ami_id`. Save these values for your deliverable.

6. Confirm in the AWS Console: EC2 -> Instances. Take a screenshot showing the running instance (Instance ID, Name tag, and Public IP visible).

7. Destroy the resources when done:

   bash
   terraform destroy -auto-approve
  

   
