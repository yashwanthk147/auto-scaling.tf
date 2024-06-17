resource "aws_autoscaling_policy" "scale_out_policy" {
  name                  = "${aws_autoscaling_group.web.name}-out"
  policy_type           = "TargetTrackingScaling"
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
  estimated_instance_warmup = 60

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_lb.web_lb.arn_suffix}/${aws_lb_target_group.TG.arn_suffix}"
    }
    target_value = var.target_value
  }
}

/*resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name          = "${aws_autoscaling_group.web.name}-out"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ALBRequestCountPerTarget"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "SampleCount"
  threshold           = 2000

  dimensions = {
    TargetGroup = "${aws_lb_target_group.TG.name}"
  }

  alarm_description = "Scale out if ALB request count exceeds 1000"
  alarm_actions     = ["${aws_autoscaling_policy.scale_out_policy.arn}"]
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                  = "${aws_autoscaling_group.web.name}-in"
  policy_type           = "TargetTrackingScaling"
  autoscaling_group_name = "${aws_autoscaling_group.web.name}"
  estimated_instance_warmup = 200

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_lb.web_lb.arn_suffix}/${aws_lb_target_group.TG.arn_suffix}"
    }
    target_value = "100"
  }
}

/*resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name          = "${aws_autoscaling_group.web.name}-in"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ALBHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "SampleCount"
  threshold           = 100

  dimensions = {
    TargetGroup = "${aws_lb_target_group.TG.name}"
  }

  alarm_description = "Scale in if ALB healthy host count is below 500"
  alarm_actions     = ["${aws_autoscaling_policy.scale_in_policy.arn}"]
}*/
