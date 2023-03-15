output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds.id
}

output "rds_private_subnet_id_1" {
  value = aws_subnet.private_rds_1.id
}

output "rds_private_subnet_id_2" {
  value = aws_subnet.private_rds_2.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "alternate_subnet_id" {
  value = aws_subnet.alternate.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
