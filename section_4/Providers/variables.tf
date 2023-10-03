variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_name" {
  type    = string
  default = "demo_vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3 #other method to fix region index issue, delete one
  }
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3 #other method to fix region index issue, delete one
  }
}

#added for 4.14 Variables Block Lesson
variable "variables_sub_cidr" { #Define CIDR
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24" #Adding defaults
}
variable "variables_sub_az" { #Define AZ
  description = "Availability Zone used Variables Subnet"
  type        = string
  default     = "us-east-1a"
}
variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assigment for Variables Subnet"
  type        = bool
  default     = true
}


#adding new var for 4.15
variable "environment" {
  description = "Environment for deployment"
  type        = string
  default     = "dev"
}