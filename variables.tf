variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "tf-ec2-demo"
}

variable "ami_id" {
  description = "Optional AMI ID — leave empty to use Amazon Linux SSM param"
  type        = string
  default     = ""
}
