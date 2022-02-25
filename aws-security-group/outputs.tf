output "bastion_sg_id" {
    value = aws_security_group.bastion-sg.id
}
output "load_balancer_sg_id" {
    value = aws_security_group.load-balancer-sg.id
}
output "private_web_server_sg_id" {
    value = aws_security_group.private-web-server.id
}
output "data_base_sg_id" {
    value = aws_security_group.data-base-sg.id
}