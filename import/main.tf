provider "aws" {
  region = "us-east-1"
  profile = "default"
}

import {
  to = aws_instance.web
  id = "i-07be8e4ee865ad083"
}

# resource "aws_instance" "web" {
  
# }