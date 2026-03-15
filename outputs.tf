#############################################################
# outputs.tf
#
# Purpose:
# Displays important infrastructure information
# after Terraform deployment completes.
#
# This helps quickly identify:
#   - EC2 Public IP
#   - Application URL
#
#############################################################

#############################################
# EC2 Public IP
#############################################

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.spring_server.public_ip
}

#############################################
# Spring Boot Application URL
#############################################

output "spring_application_url" {
  description = "Access the Spring Boot application in browser"
  value       = "http://${aws_instance.spring_server.public_ip}:${var.app_port}"
}