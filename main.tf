module "Monitoring" {
  source = "./tf_module"
  profile = "default"
  region = ""
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
