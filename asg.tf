resource "aws_autoscaling_group" "web" {
  name = var.autoscaling_group_name
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  health_check_type = "EC2"
  health_check_grace_period = var.health_check_grace_period
  default_cooldown  = var.default_cooldown
  vpc_zone_identifier = var.private_subnets
  target_group_arns = [aws_lb_target_group.TG.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }
  
  tag {
    key                 = "Name"
    value               = var.value
    propagate_at_launch = true
  }
  
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.min_healthy_percentage
      instance_warmup        = var.instance_warmup
    }
    triggers = ["tag"]
  }
}
resource "aws_autoscaling_lifecycle_hook" "TerminationHook" {
  name                    = "TerminationHook"
  autoscaling_group_name  = "${aws_autoscaling_group.web.name}"
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = var.notification_target_arn
  role_arn                = var.role_arn
  default_result          = "ABANDON"
  notification_metadata   = "Warning: EC2Instance is going to be terminated !!!"
  heartbeat_timeout       = var.heartbeat_timeout


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_lifecycle_hook" "LaunchingHook" {
  name                    = "LaunchingHook"
  autoscaling_group_name  = "${aws_autoscaling_group.web.name}"
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_LAUNCHING"
  notification_target_arn = var.notification_target_arn
  role_arn                = var.role_arn
  default_result          = "CONTINUE"
  notification_metadata   = "EC2 Instance is being launched !!!"
  heartbeat_timeout       = var.heartbeat_timeout


  lifecycle {
    create_before_destroy = true
  }
}



  
