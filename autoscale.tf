resource "aws_autoscaling_group" "ats" {
  vpc_zone_identifier = [aws_subnet.private[0].id, aws_subnet.private[1].id]
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app_tg.arn]

  tag {
    key                 = "Name"
    value               = "server-asg"
    propagate_at_launch = true
  }
}