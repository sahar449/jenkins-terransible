data "aws_ami" "latest_ubuntu" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
    name   = "name"
    values = ["ubuntu-*"]
  }
}