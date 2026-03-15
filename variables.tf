#############################################################
# variables.tf
#
# Purpose:
# Defines all configurable input variables used by Terraform.
# This keeps infrastructure flexible and reusable.
#############################################################

# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

# EC2 AMI ID
variable "ami_id" {
  description = "AMI ID for Ubuntu EC2 instance"
  type        = string
  default     = "ami-019715e0d74f695be"
}

# EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type (Free tier eligible)"
  type        = string
  default     = "t3.micro"
}

# EC2 Key Pair
variable "key_pair_name" {
  description = "Existing AWS key pair used to SSH into EC2"
  type        = string
  default     = "keypairfor_allTraffic1"
}

# Instance Name Tag
variable "instance_name" {
  description = "Tag name for EC2 instance"
  type        = string
  default     = "springboot-terraform-server"
}

# Application Port
variable "app_port" {
  description = "Port where Spring Boot application runs"
  type        = number
  default     = 8085
}