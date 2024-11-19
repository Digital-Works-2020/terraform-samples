#Define Variable Region
variable "region" {
  type = string
}

#Define Search Pattern
variable "search_pattern" {
  type = string
}

#Get the Region from EndUser
provider "aws" {
  region = var.region
}

#Extract EC2 Machines matching the given pattern in given region
data "aws_instances" "ec2_instances_search" {
  filter {
    name   = "tag:Name"
    values = ["*${var.search_pattern}*"]
  }
}

#For Each Found EC2, Get all of its attributes
data "aws_instance" "each_instance" {
  for_each    = toset(data.aws_instances.ec2_instances_search.ids)
  instance_id = each.key
}

#Using Above Data, Print List of Dictionaries with each dictionary having Instance ID, Private IP & Name of instance
output "instances_info" {
  value = [
    for instance in data.aws_instances.ec2_instances_search.ids : {
      id         = instance
      private_ip = data.aws_instance.each_instance[instance].private_ip
      name       = data.aws_instance.each_instance[instance].tags["Name"]
    }
  ]
}
