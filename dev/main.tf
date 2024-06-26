# Variables Block
# Common values used across the terraform code can be added as variables
# We can override the values using .tfvars files while running terraform plan/apply
variable "region" {
default = "us-east-1"
}

variable "instance_count_needed" {
  default = "false"
}

variable "instance_count" {
  default = 1
}

# Terraform Required provider Block
# In this section, we need to declare the providers and their version constraint used to create the infrastructure
# It is needed to avoid any version mismatch of the provider 
# Also it is good to mention what is the required version of Terraform CLI needed for the infra creation
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# Provider block declares the provider on which the infra will be created
# For AWS, one way of doing the cred authentication is to install AWS CLI and configure it to add access_key_id and secret_access_key
provider "aws" {
  profile = "default"
  region  = var.region
}

# Resource Block
# In this section, we will add the resources that we will be adding and managing in Cloud infra
# 
resource "aws_instance" "app_server" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  
  # In terraform conditional statements are possible
  count = var.instance_count_needed ? var.instance_count : 1

  # We can use the provisioners like user_data to run scripts that will be executed when the instance is getting created.
  user_data = <<-EOF
  #!/bin/bash
  echo "This script was executed from user_data"
  EOF

  tags = {
    Name = "ExampleAppServer"
  }
}

terraform {  
  backend "s3" {

  }  
}

# Output Block
# Here we can print the values of Infra resources that is supported
# For ex: We are printing instance_id and instance_state
output "instance_id" {
  description = "ID of the EC2 instance(s)"
  value       = aws_instance.app_server.*.id
}

output "instance_state" {
  description = "State of the EC2 instance(s)"
  value       = aws_instance.app_server.*.instance_state
}
