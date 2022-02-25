output "private_ips" {
  value = flatten(data.aws_instances.app.private_ips)
}

output "db_host_endpoint" {
  value = module.database.database_address
}

output "name" {
  value = abspath(path.module)
}
# output "subnets_id" {
#     value = module.database.subnets-ids
# }
