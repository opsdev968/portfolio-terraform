variable "EC2_INSTANCE_NUMBER" {    
    default = 3
}

variable "SUBNET_NUMBER" {    
    default = 2  
}
variable "EC2_USER" {
    default = "ubuntu"
}

variable "AWS_REGION" {    
    default = "eu-west-2"  
}

variable "PUBLIC_KEY_PATH" {
    default = "/mnt/c/Users/user/Desktop/DevOps/TERAFORM/london-region-key-pair.pub"
}

variable "PRIVATE_KEY_PATH" {
    default = "/mnt/c/Users/user/Desktop/DevOps/TERAFORM/london-region-key-pair"
}

variable "OWNERTAG" {    
    default = "olgag"
}

variable "aws_vpc_modules_version" {
 type = string
 default = "3.1.0"
}

variable "eks_machine_type" {    
    default = "t3a.large"
}

variable "aws_nat_gateway_modules_version" {
  type = string
  default = "3.0.0"
}

variable "my_name" {
  type = string
  default = "olgag"
}

variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "tag_environment" {
  type = string
  default = "dev"
}

variable "private_subnet_cidr_blocks" {
   type = list(string) 
   description = "List of CIDR blocks for private subnets"
   default  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidr_blocks" { 
     type = list(string)
  description = "List of CIDR blocks for public subnets"
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}


#data "aws_availability_zones" "available" {
#  state = "available"
#}