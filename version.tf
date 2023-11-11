# # Terraform Block
terraform {
  required_version = "~> 1.6" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
   publicip {
    provider_url = "https://ifconfig.co/"
    }
  }
}
# Provider Block
provider "aws" {
  region = "us-east-1"
}
