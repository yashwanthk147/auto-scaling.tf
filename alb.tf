resource "aws_lb" "web_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.sg_lb.id]
  subnets = var.public_subnets

  enable_deletion_protection = false
  
  tags = {
    Environment = var.Environment
  }
}

resource "aws_lb_target_group" "TG" {
  name     = var.lb_target_group_name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.healthpath
    interval            = 125
    timeout             = 120
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "listener_tls" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  ssl_policy        = var.ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}
