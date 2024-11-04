#Creation of EC2 Instance with User Data & Key Pair
resource "aws_instance" "cerberus" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.cerberus-key.key_name
  user_data     = file("install-nginx.sh")
}

#Creation of AWS Key Pair using local public key
resource "aws_key_pair" "cerberus-key" {
  key_name   = "cerberus"
  public_key = file("/root/.ssh/cerberus.pub")
}

#Creation of Elastic IP and associate to newly created EC2 & Print Public DNS to text file
resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.cerberus.id
  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> /root/cerberus_public_dns.txt"
  }
}

#Variables Used in above resource creations
variable "region" {
  default = "eu-west-2"
}
variable "ami" {
  default = "ami-06178cf087598769c"
}
variable "instance_type" {
  default = "m5.large"
}
