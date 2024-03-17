data "aws_ami" "latest_ubuntu" {
    most_recent = true
    owners = [ "aws-marketplace" ]
    filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*"]
  }
}