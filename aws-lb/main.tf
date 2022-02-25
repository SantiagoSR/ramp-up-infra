
resource "aws_lb_target_group" "lb-target-group" {
  health_check {
    interval = 10
    path = "/"
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 2
    
  }
  name = "load-balancer-target-group-ssr"
  port = 3030
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = "vpc-0d2831659ef89870c"

  tags = {
    Name = var.lb_target_group_name
  }
}

resource "aws_lb" "load-balancer-ramp-up-ssr" {
  name = "load-balancer-ramp-up-ssr"
  internal = false
  
  security_groups = ["${var.security_groups}"]
  subnets = ["subnet-0088df5de3a4fe490", "subnet-055c41fce697f9cca"]
  tags = {
    Name = var.load_balancer_ramp_up_name
  }
  ip_address_type = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "load-balancer-listner-ssr" {
  load_balancer_arn = aws_lb.load-balancer-ramp-up-ssr.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = "${aws_lb_target_group.lb-target-group.arn}"
    type = "forward"
  }  
}