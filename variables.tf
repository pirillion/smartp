variable "aws_access_key" {
    default = "" 
}
variable "aws_secret_key" {
    default = "" 
}
variable "aws_key_path" {
    default = "/root/terraform-ansible/terraform"
}
variable "aws_key_name" {
    default = "ansible"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-13be557e"
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "public2_subnet_cidr" {
    description = "CIDR for the Public2 Subnet"
    default = "10.0.1.0/24"
}
