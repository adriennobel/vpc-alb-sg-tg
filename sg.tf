
# security group alb
resource "aws_security_group" "alb" {
  name = "alb-code"
  description = "allow 80 and 443"
  vpc_id = aws_vpc.vpc1.id
  ingress {
    description = "allow 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# security group web server
resource "aws_security_group" "ws" {
  name = "ws-alb"
  description = "allow 80"
  vpc_id = aws_vpc.vpc1.id
  ingress {
    description = "allow 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}