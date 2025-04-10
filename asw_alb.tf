resource "aws_alb" "bia" {
  name = "bia-alb"
  load_balancer_type = "application"
  subnets = [
    local.subnet_id_zona_a,
    local.subnet_id_zona_b,
  ]
  security_groups = [ aws_security_group.bia_alb_tf.id ]
}

resource "aws_lb_target_group" "tg_bia" {
  name_prefix = "bia-"
  vpc_id = local.vpc_id
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  deregistration_delay = 30
  
  health_check {
    enabled = true
    path = "/api/versao"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "bia" {
  load_balancer_arn = aws_alb.bia.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_bia.arn
  }
}
