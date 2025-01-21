resource "aws_instance" "ec2-1" {
  availability_zone = "us-east-1a"
  ami = "ami-045269a1f5c90a6a0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ws.id]
  user_data = file("code.sh")
  subnet_id = aws_subnet.priv1.id
  tags = {
    "Name" = "webserver-1"
  }
}

resource "aws_instance" "ec2-2" {
  availability_zone = "us-east-1b"
  ami = "ami-045269a1f5c90a6a0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ws.id]
  user_data = file("code.sh")
  subnet_id = aws_subnet.priv2.id
  tags = {
    "Name" = "webserver-2"
  }
}