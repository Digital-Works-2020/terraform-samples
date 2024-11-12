#AWS Provider Default Region
provider "aws" {
  region     = "us-east-1"
}

#Variable Employee ID
variable "employee_id" {
  type = string
}

#Variable Employee Name
variable "employee_name" {
  type = string
}

#Add DynamoDB item to table
resource "aws_dynamodb_table_item" "employee" {
  table_name = aws_dynamodb_table.employee_db.name
  hash_key   = aws_dynamodb_table.employee_db.hash_key
  #Item should be in JSON Format Key Value Pairs. Value Should be a dictionary of Data Type & Value
  item       = <<ITEM
  {
    "EmployeeID" : {"S" : "${var.employee_id}"},
    "Name"       : {"S" : "${var.employee_name}"}
  }
  ITEM
}

#Default Billing mode for Dynamo DB is PROVISIONED. When Billing mode is PROVISIONED, read_capacity and write_capacity must be atleast 1
resource "aws_dynamodb_table" "employee_db" {
  name = "Employee"
  #The Defined Hash Key should have an attribute section
  hash_key       = "EmployeeID"
  read_capacity  = 1
  write_capacity = 1
  attribute {
    name = "EmployeeID"
    type = "S" #S for String
  }
}
