resource "aws_instance" "web" {
  ami                                  = "ami-0c614dee691cbbf37"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  instance_type                        = "t2.micro"
  key_name                             = "windows_server"
  monitoring                           = false
  subnet_id                            = "subnet-0ea286d0d4beef530"
  vpc_security_group_ids      = ["sg-0b31cba6c4188bab8"]

  tags = {
    Name = "terraform-import"
  }
}
