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

resource "aws_instance" "Webphp-server" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  subnet_id = "subnet-04bf87a4d517f4863"
  key_name        = "lab1"
 
  user_data = <<-EOF
       #!/bin/bash
      #### Webinstall
      sudo su
      yum update -y
      yum install httpd -y
      amazon-linux-extras install epel
      yum install epel-release
      rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
      yum install -y php70 php70-php php70-php-fpm php70-php-pecl-memcached php70-php-mysqlnd php70-php-xml
      ln -s /usr/bin/php70 /usr/bin/php
      yum install git -y
      systemctl start httpd.service
      systemctl enable httpd.service
  EOF
 
  tags = {

    Name = "Webphp-server02"
  
  }
}


