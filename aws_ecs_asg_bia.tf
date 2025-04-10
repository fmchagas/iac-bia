resource "aws_autoscaling_group" "fmctf_ecs" {
  name_prefix               = "fmctf-ecs-bia-asg-"
  vpc_zone_identifier       = [local.subnet_id_zona_a, local.subnet_id_zona_b]
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 0
  health_check_type         = "EC2"
  protect_from_scale_in     = false # redução de instâncias

  launch_template {
    id      = aws_launch_template.fmctf_ecs_ec2.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [ desired_capacity ]
  }

  tag {
    key                 = "Name"
    value               = "fmctf-cluster-bia"
    propagate_at_launch = true
  }
  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }
}

