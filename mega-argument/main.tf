# provider "aws" {
#   region = "us-east-1"
#   profile = "default"
# }

# resource "aws_instance" "s1" {
#   count = 2

#   ami = "ami-0c614dee691cbbf37"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "dev-server${count.index}"
#   }
# }

# resource "aws_iam_user" "us1" {
#   name = "cloudadmin"
#   depends_on = [ aws_instance.s1 ]
# }

# output "ip" {
#   value = aws_instance.s1[*].public_ip
# }

# variable "info" {
#   type = map(object({
#     ami = string
#     instance = string
#   }))
#   default = {
#     dev = {
#       ami: "ami-045269a1f5c90a6a0",
#       instance: "t2.micro"
#     }
#     qa = {
#       ami: "ami-045269a1f5c90a6a0",
#       instance: "t2.micro"
#     }
#   }
# }

# resource "aws_instance" "s2" {
#   for_each = var.info
#   ami = each.value.ami
#   instance_type = each.value.instance
#   tags = {
#     "Name" = each.key
#   }
# }

# provider "aws" {
#   region = var.region
# }

# variable "region" {
#   description = "value of region"
#   type = string
#   # sensitive = true
#   # default = "us-east-1"
# }

# provider "aws" {
#   region = "us-east-1"
#   alias = "use1"
# }

# provider "aws" {
#   region = "us-west-1"
#   alias = "usw1"
# }

# resource "aws_instance" "server0" {
#   provider = aws.use1
#   ami = "ami-0c614dee691cbbf37"
#   instance_type = "t2.micro"
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
  ami = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
  }
}
