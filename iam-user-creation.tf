#Using Specific  Version of Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.0"
    }
  }
}

#Specify Default Region
provider "aws" {
  region     = "us-east-1"
}

#Create IAM User
resource "aws_iam_user" "Admin-User" {
  name = "Admin" #Only Required Parameter
  tags = {
    Description = "Administrative Previliges"
  }
}

#Create IAM Group
resource "aws_iam_group" "Administrators" {
  name = "Administrators" #Only Required Parameters
}

#Attach Policy to Group
resource "aws_iam_group_policy_attachment" "Administrator-Attachment" {
  #Group & Policy ARN are mandate
  group      = aws_iam_group.Administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#Attach User to Group
resource "aws_iam_user_group_membership" "Admin-Attachment" {
  #User & Groups are mandate
  user = aws_iam_user.Admin-User.name
  groups = [
    aws_iam_group.Administrators.name
  ]
}

#Enable Console Access for User
resource "aws_iam_user_login_profile" "Admin_Console_Access" {
  user = aws_iam_user.Admin-User.name #Only Required Argument
}
