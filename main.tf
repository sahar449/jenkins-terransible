module "Monitoring" {
  source = "./tf_module"
  #profile = "default"
  access_key = ""
  secret_key = "" 
}

terraform {
  backend "s3" {
    bucket = "sahar-tf"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

#Provider Block
provider "aws" {
  region = "us-east-1"
}

# # Terraform Block
terraform {
  required_version = "~> 1.6" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}