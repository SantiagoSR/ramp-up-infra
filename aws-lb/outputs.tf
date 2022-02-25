output "load-balancer-ramp-up-ssr" {
    value = aws_lb.load-balancer-ramp-up-ssr.arn
}
output "alb_target_group_arn"{
    value = aws_lb_target_group.lb-target-group.arn
}