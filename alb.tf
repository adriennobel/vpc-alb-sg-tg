resource "aws_lb_target_group" "tg1" {
  name = "alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc1.id
  health_check {
    enabled = true
    path = "/"
    port = "80"
    protocol = "HTTP"
    timeout = 6
    interval = 100
    matcher = 200
    healthy_threshold = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "alb-tg-attachment1" {
  target_group_arn = aws_lb_target_group.tg1.arn
  target_id = aws_instance.ec2-1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "alb-tg-attachment2" {
  target_group_arn = aws_lb_target_group.tg1.arn
  target_id = aws_instance.ec2-2.id
  port = 80
}

resource "aws_lb" "alb" {
  name = "alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = [aws_subnet.pub1.id, aws_subnet.pub2.id]
  enable_deletion_protection = false
  # enable_http2 = true
  # enable_cross_zone_load_balancing = true
  # idle_timeout = 60
  tags = {
    Name = "alb"
    Env = "dev"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}