output "private_ips" {
  value = flatten(data.aws_instances.app.private_ips)
}

output "db_host_endpoint" {
  value = module.database.database_address
}

output "bastion_ip" {
  value = module.bastion_host.bastion_host_public_ip
}
output "path" {
  value = abspath(path.module)
}