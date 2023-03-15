variable "project" {
  description = "Name of project"
}

variable "stack" {
  description = "Platform used on Elastic Beanstalk instance"
}

variable "vpc_id" {
  description = "ID of Virtual Private Cloud that houses environment"
}

variable "subnet_id" {
  description = "ID of public subnet"
}

variable "alternate_subnet_id" {
  description = "ID of alternate subnet"
}

variable "security_group_id" {
  description = "ID of security group which acts of virtual firewall"
}

variable "instance_type" {
  description = "Capacity of Elastic Beanstalk instance"
}