variable "region" {
  type        = string
  description = "Give the region in which you want to create VPC"
}

variable "vpc_name" {
  type        = string
  description = "Give the Name for the VPC which you are creating"
}

variable "cidr_block" {
  type        = string
  description = "Give the CIDR Block for the VPC you are creating"
}

variable "public_subnets" {
  default = {
    "Public Subnet1" = 0
    "Public Subnet2" = 1
    "Public Subnet3" = 2
  }
}

variable "private_subnets" {
  default = {
    "Private Subnet1" = 0
    "Private Subnet2" = 1
    "Private Subnet3" = 2
  }
}
