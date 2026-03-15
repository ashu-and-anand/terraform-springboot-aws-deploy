#############################################################
# terraform.tfvars
#
# Purpose:
# Contains actual values for Terraform variables.
# This file allows changing deployment configuration
# without modifying infrastructure code.
#############################################################

aws_region      = "ap-south-1"

ami_id          = "ami-019715e0d74f695be"

instance_type   = "t3.micro"

key_pair_name   = "keypairfor_allTraffic1"

instance_name   = "springboot-terraform-server"

app_port        = 8085