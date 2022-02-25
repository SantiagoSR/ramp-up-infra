variable "instance_project" {
  description = "Name of the project"
  type        = string
  default     = "ramp-up-devops"
}
variable "instance_responsile" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "santiago.santacruzr"
}

variable "bastion_host_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "bastion_host"
}

variable "lb_target_group_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "load_balancer_target_group_ssr"
}

variable "load_balancer_ramp_up_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "load_balancer_ramp_up_ssr"
}
variable "auto_scaling_ramp_up_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "auto_scaling_ramp_up_ssr"
}


variable "db_subnet_terraform_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "db_subnet_terraform"
}

variable "private_web_server_name" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "sg_Private_Server_ssr"
}
variable "bastion_sg" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "sg_bastion_host_ssr"
}
variable "load_balancer_sg" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "sg_load_balancer_ssr"
}
variable "data_base_sg" {
  description = "Responsible for the creation of the resources"
  type        = string
  default     = "sg_data_base_ssr"
}

