#AWS Provider to choose region
provider "aws" {
  region = var.region
}

#To Get Availablity Zones in the current region
data "aws_availability_zones" "available_zones" {
}

#Create VPC with given CDR Block
resource "aws_vpc" "MyVPC" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

#Create group of public subnets. For CIDR, Using cidrsubnet function to generate CIDR on the fly
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  cidr_block              = cidrsubnet(var.cidr_block, 8, each.value + 1)
  availability_zone       = tolist(data.aws_availability_zones.available_zones.names)[each.value]
  vpc_id                  = aws_vpc.MyVPC.id
  map_public_ip_on_launch = true
  tags = {
    Name = each.key
  }

}

#Create group of private subnets. For CIDR, Using cidrsubnet function to generate CIDR on the fly
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  cidr_block        = cidrsubnet(var.cidr_block, 8, each.value + 100)
  availability_zone = tolist(data.aws_availability_zones.available_zones.names)[each.value]
  vpc_id            = aws_vpc.MyVPC.id
  tags = {
    Name = each.key
  }

}

#Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.MyVPC.id
  tags = {
    Name = "My Internet Gateway"
  }
}

#Create Elastic IP at VPC Level to use for NAT Gateway
resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "My Elastic IP"
  }
}

#Create NAT Gateway. For Public Connectivity, It needs to be assoaciated with Elastic IP and it needs to reside in Public Subnet
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets["Public Subnet1"].id
  depends_on    = [aws_subnet.public_subnets]
  tags = {
    Name = "My NAT Gateway"
  }
}

#Create Route Table for Public Subnet
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.MyVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public Route Table"
  }
}

#Create Route Table for Private Subnet
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.MyVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "Private Route Table"
  }
}

#Create Route Table Entry for Public Route Table for internet connectivity via Internet Gateway and associate to Public Subnets
resource "aws_route_table_association" "public_association" {
  route_table_id = aws_route_table.public_route.id
  subnet_id      = each.value.id
  for_each       = aws_subnet.public_subnets
  depends_on     = [aws_subnet.public_subnets]
}

#Create Route Table Entry for Private Route Table for internet connectivity via NAT Gateway and associate to Private Subnets
resource "aws_route_table_association" "private_association" {
  route_table_id = aws_route_table.private_route.id
  subnet_id      = each.value.id
  for_each       = aws_subnet.private_subnets
  depends_on     = [aws_subnet.private_subnets]
}
