resource "aws_network_interface_sg_attachment" "sg_attachment_bastion" {
  security_group_id    = var.security_groups
  network_interface_id = var.network_interface
}
