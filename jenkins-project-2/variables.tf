# Denfine the region
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Define the AMI of the instance, Linux 2023 for this project
variable "instance-ami" {
  description = "AMI for Jenkins instance"
  type        = string
  default     = "ami-067d1e60475437da2"
}
# Define instance type
variable "instance-type" {
  description = "Instance type for Jenkins instance"
  type        = string
  default     = "t2.micro"
}

# Define VPC
variable "instance-vpc" {
  description = "VPC for Jenkins instanc"
  type        = string
  default     = "vpc-002f5af18e65786d0"
}

# Define Key Pair
variable "key-pair" {
  description = "Key pair name"
  type        = string
  default     = "ameyermunoz-kp"
}

variable "jenkins-bucket" {
  description = "jenkins bucket"
  type        = string
  # default    = "jenkins-bucket-fp232isdnuhf1"
}