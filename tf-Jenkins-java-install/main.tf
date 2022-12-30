######################## Providers ################################
terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.28.0"

    }
  }

}

provider "aws" {
  region  = "us-east-1"
  profile = "default"

  # default_tags {
  #   tags = {
  #     App = "terraform_aws_rds_secrets_manager"
  #   }
  # }
}

########################## Create EC2 ###########################

resource "aws_instance" "Jenkin-lab" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  subnet_id = "subnet-04bf87a4d517f4863"
  key_name        = "lab1"
 
  user_data = <<-EOF
       #!/bin/bash
      ### Install Java
      sudo amazon-linux-extras install java-openjdk11
      ### Intsall Jenkins
      sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
      sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
      sudo yum install -y jenkins
      ## Start Jenkins
      sudo systemctl start jenkins
  EOF
 
  tags = {

    Name = "Jenkins-Java-EC2"
    
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.main.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.main.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    # cidr_blocks      = [aws_vpc.main.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

