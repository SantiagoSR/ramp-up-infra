provider "aws" {
  region  = "us-west-1"
  shared_credentials_file = "/var/lib/jenkins/.aws/credentials"

  default_tags {
    tags = {
      project     = var.instance_project,
      responsible = var.instance_responsile
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


module "bastion_host" {
  source = "./aws-bastion"
  instance_project = var.instance_project
  instance_responsile = var.instance_responsile
  bastion_host_name = var.bastion_host_name
  instances_ips = data.aws_instances.app.private_ips
  ami_id = data.aws_ami.ubuntu.id
  path = abspath(path.root)
  depends_on = [
    module.autoscaling_group,
    data.aws_instances.app
  ]
}

module "security_groups" {
  source = "./aws-security-group" 
  instance_project = var.instance_project
  instance_responsile = var.instance_responsile
  private_web_server_name = var.private_web_server_name
  bastion_sg = var.bastion_sg
  load_balancer_sg = var.load_balancer_sg
  data_base_sg = var.data_base_sg
}

module "load_balancer" {
  source = "./aws-lb" 
  lb_target_group_name = var.lb_target_group_name
  load_balancer_ramp_up_name = var.load_balancer_ramp_up_name
  security_groups = module.security_groups.load_balancer_sg_id
}
module "autoscaling_group" {
  source = "./aws-autoscaling"
  instance_project = var.instance_project
  instance_responsile = var.instance_responsile
  auto_scaling_ramp_up_name = var.auto_scaling_ramp_up_name
  image_instance = data.aws_ami.ubuntu.id
  security_groups = module.security_groups.private_web_server_sg_id
  alb_target_group = module.load_balancer.alb_target_group_arn
}

module "database" {
  source = "./aws-db"
  instance_project = var.instance_project
  instance_responsile = var.instance_responsile
  security_groups = module.security_groups.data_base_sg_id
  db_subnet_terraform_name = var.db_subnet_terraform_name
  depends_on = [
    module.security_groups
  ]
  
}

data "aws_instances" "app" {
  instance_tags = {
#     Use whatever name you have given to your instances
    Name = "Web Server"
  }
  depends_on = [
    module.autoscaling_group
  ]
}
#>/mnt/c/Perficient/RampUp/Server_Configuration_managment/inventory.json
# resource "null_resource" "inventory_ansible_2" {
#   provisioner "local-exec" {
#     working_dir = abspath(path.module)
#     command = "private_ips>>/mnt/c/Perficient/RampUp/Server_Configuration_managment/inventory.json"
#     interpreter=["terraform", "output", "-json"]
#   }
#   depends_on = [
#     module.autoscaling_group,
#     data.aws_instances.app
#   ]
# }

module "bastion_attachment" {
  source = "./aws-attachment"
  security_groups = module.security_groups.bastion_sg_id
  network_interface = module.bastion_host.primary_network_interface_id
  
}

