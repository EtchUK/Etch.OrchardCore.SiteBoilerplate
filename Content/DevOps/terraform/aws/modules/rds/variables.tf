variable "db_name" {
  description = "Name of the database instance."
}

variable "db_password" {
  description = "Password credential for RDS database access."
}

variable "db_username" {
  description = "Username credential for RDS database access."
}

variable "project" {
  description = "Name of project"
}

variable "security_group_id" {
  description = "ID of security group which acts of virtual firewall"
}

variable "private_subnet_id_1" {
  description = "ID of first private subnet for RDS"
}

variable "private_subnet_id_2" {
  description = "ID of second private subnet for RDS"
}

variable "instance_class" {
  description = "Instance type of RDS instance"
}