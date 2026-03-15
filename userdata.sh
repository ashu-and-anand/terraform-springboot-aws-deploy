#!/bin/bash

#############################################################
# userdata.sh
#
# Purpose:
# This script runs automatically when the EC2 instance starts.
# Terraform sends this script to AWS using the "user_data" block.
#
# The script performs the following actions automatically:
#
# 1. Update system packages
# 2. Install Java 17
# 3. Install Maven
# 4. Install MySQL Server
# 5. Configure MySQL authentication
# 6. Create application database
# 7. Install Git
# 8. Clone Spring Boot project
# 9. Fix database host configuration
# 10. Build the application
# 11. Run Spring Boot application in background
#
#############################################################

echo "Starting server configuration..."

#############################################################
# Update system packages
#############################################################

sudo apt update -y

#############################################################
# Install Java 17
#############################################################

sudo apt install openjdk-17-jdk -y

#############################################################
# Install Maven
#############################################################

sudo apt install maven -y

#############################################################
# Install Git
#############################################################

sudo apt install git -y

#############################################################
# Install MySQL Server
#############################################################

sudo apt install mysql-server -y

#############################################################
# Start MySQL Service
#############################################################

sudo systemctl start mysql
sudo systemctl enable mysql

#############################################################
# Configure MySQL root password authentication
#############################################################

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '1234';"
sudo mysql -e "FLUSH PRIVILEGES;"

#############################################################
# Create database for Spring Boot
#############################################################

sudo mysql -e "CREATE DATABASE IF NOT EXISTS myapplication;"

#############################################################
# Clone Spring Boot project
#############################################################

cd /home/ubuntu

git clone https://github.com/sakit333/spring_mysql_kubeadm_sakcoorg.git

cd spring_mysql_kubeadm_sakcoorg

#############################################################
# Fix MySQL host configuration
#############################################################

sed -i 's/mysql-service/localhost/g' src/main/resources/application.properties

#############################################################
# Build Spring Boot Application
#############################################################

mvn clean package

#############################################################
# Run Spring Boot Application in Background
#############################################################

nohup java -jar target/*.jar > app.log 2>&1 &

echo "Spring Boot application deployed successfully"