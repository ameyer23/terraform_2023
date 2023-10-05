#Resource Block To Build EC2 instance 
resource "aws_instance" "jenkins_server" {
  ami           = var.instance-ami
  instance_type = var.instance-type
  key_name      = var.key-pair
  user_data     = file("jenkins-script.sh")
  tags = {
    Name = "Jenkins EC2 Server"
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

  egress { #Allow outbound traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-security-group"
  }
}

resource "aws_s3_bucket" "new-jenkins-S3-bucket" {
  bucket = var.jenkins-bucket                
  tags = {
    Name    = "Jenkins S3 Bucket"      
    Purpose = "Private Jenkins Bucket"
  }
}