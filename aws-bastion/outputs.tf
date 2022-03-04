# output "ami_id" {
#     value = data.aws_ami.ubuntu.id
# }

output "primary_network_interface_id" {
    value = aws_instance.bastion-host.primary_network_interface_id
}
output "bastion_host_private_ip" {
    value = aws_instance.bastion-host.private_ip
}