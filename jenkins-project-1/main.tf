#Configure AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Resource Block To Build EC2 instance 
resource "aws_instance" "server" { #Instance is a web server
  ami           = "ami-067d1e60475437da2"
  instance_type = "t2.micro"
  key_name      = "ameyermunoz-kp"
  user_data     = <<-EOF
    #!/bin/bash
    sudo yum update –y
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade
    sudo amazon-linux-extras install java-openjdk11 -y
    sudo dnf install java-11-amazon-corretto -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo systemctl status jenkins
  EOF
  tags = {
    Name = "Jenkins EC2 Server" #Name of instance
  }
  vpc_security_group_ids = [aws_security_group.jenkins-security-group.id]
}

#Create security groups with ssh and web access
resource "aws_security_group" "jenkins-security-group" {
  name        = "jenkins-sg"
  description = "Allow incoming web traffic from port 80 and 22"
  vpc_id      = "vpc-002f5af18e65786d0" 

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                    
  }
  
  egress {                                              
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "Jenkins-security-group"
  }
}

resource "aws_s3_bucket" "new-jenkins-S3-bucket" {
  bucket = "jenkins-bucket-983fiow-proj"                    #Name of the bucket
  tags = {
    Name    = "Jenkins S3 Bucket" 
    Purpose = "Private Jenkins Bucket"
  }
}