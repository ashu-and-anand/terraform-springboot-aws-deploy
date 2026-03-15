#############################################################
# main.tf
#
# Purpose:
# Defines the core infrastructure resources:
#   1. AWS Provider
#   2. Security Group
#   3. EC2 Instance
#
# The EC2 instance will automatically:
#   - Install Java
#   - Install Maven
#   - Install MySQL
#   - Clone Spring Boot project
#   - Build the project
#   - Start the application
#
#############################################################

############################
# AWS Provider Configuration
############################

provider "aws" {
  region = var.aws_region
}

############################
# Security Group
############################

resource "aws_security_group" "spring_app_sg" {

  name        = "spring-app-security-group"
  description = "Allow SSH and Spring Boot traffic"

  ############################
  # Allow SSH
  ############################

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ############################
  # Allow Spring Boot Port
  ############################

  ingress {
    description = "Spring Boot Application"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ############################
  # Outbound Traffic
  ############################

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "spring-app-sg"
  }

}

############################
# EC2 Instance
############################

resource "aws_instance" "spring_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  associate_public_ip_address = true
  
  ############################
  # Attach Security Group
  ############################

  vpc_security_group_ids = [
    aws_security_group.spring_app_sg.id
  ]

  ############################
  # Root Volume Configuration
  ############################

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  ############################
  # User Data Script
  ############################

  user_data = file("userdata.sh")

  ############################
  # Instance Tags
  ############################

  tags = {
    Name = var.instance_name
  }

}