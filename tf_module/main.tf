#--- tf_module ---#

resource "aws_instance" "prometheus" {
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "jenkins"
  vpc_security_group_ids = [ aws_security_group.prometheus.id ]
  provisioner "local-exec" {
      command = "sleep 60 && ansible-playbook -i ${self.public_ip}, playbooks/promethus.yml  -u=ubuntu --key-file /home/sahar/Downloads/jenkins.pem"
  }
  tags = {
    Name = "Prometheus"
  }
}

resource "aws_instance" "grafana" {
  ami = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = "jenkins"
  vpc_security_group_ids = [ aws_security_group.grafana.id ]
  provisioner "local-exec" {
    command = "sleep 60 && ansible-playbook -i ${self.public_ip}, playbooks/grafana.yml -u=ubuntu --key-file /home/sahar/Downloads/jenkins.pem"
  }
  tags = {
    Name = "Grafana"
  }
}

resource "aws_security_group" "prometheus" {
  name        = "sg_prometheus"
  dynamic "ingress" {
    for_each = [22, 9090]
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["46.121.44.252/32"]  #My public ip
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "grafana" {
  name        = "sg_grafana"
  dynamic "ingress" {
    for_each = [22, 3000]
    content {
      description = "TLS from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["46.121.44.252/32"]  #My public ip
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "null_resource" "test_prometheus" {
   depends_on  =   [ aws_instance.prometheus ] 
  provisioner "local-exec" {
    command = "sleep 30 && telnet ${aws_instance.prometheus.public_ip} 9090"
  }

}

resource "null_resource" "test_grafana" {
  depends_on = [ aws_instance.grafana ]
  provisioner "local-exec" {
    command = "sleep 30 && telnet ${aws_instance.grafana.public_ip} 3000"
  }
}

