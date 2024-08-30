# Target group for the ALB

resource "aws_lb_target_group" "app_tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 40
    interval            = 60
    path                = "/index.html" 
    port                = 80
  }
}

resource "aws_lb_target_group_attachment" "ec2-attachment1" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2-attachment2" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server2.id
  port             = 80
}

