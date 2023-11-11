# # Terraform Block
terraform {
  required_version = "~> 1.6" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    public_ip{
      source = "/hashicorp/publicip"
    }
  }
}
# Provider Block
provider "aws" {
  region = "us-east-1"
}
