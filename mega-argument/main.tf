provider "aws" {
  region = "us-east-1"
  profile = "default"
}

resource "aws_instance" "s1" {
  count = 2

  ami = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"

  tags = {
    Name = "dev-server${count.index}"
  }
}

resource "aws_iam_user" "us1" {
  name = "cloudadmin"
  depends_on = [ aws_instance.s1 ]
}

output "ip" {
  value = aws_instance.s1[*].public_ip
}