variable "instance_project" {
  description = "Name of the project"
  type        = string
}
variable "instance_responsile" {
  description = "Responsible for the creation of the resources"
  type        = string
}

variable "bastion_host_name" {
  description = "Responsible for the creation of the resources"
  type        = string
}

variable "instances_ips" {
  description = "Ips of ASG instances"
  type        = list(string)
}
variable "path" {
  description = "Path to home"
  type        = string
}

variable "ami_id"{
  description = "ami"
  type        = string
}