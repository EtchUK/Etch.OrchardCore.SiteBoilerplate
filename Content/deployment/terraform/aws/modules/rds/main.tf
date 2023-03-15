resource "aws_db_subnet_group" "rds_priv_subnet" {
  name       = "${var.project}-rds-private"
  subnet_ids = ["${var.private_subnet_id_1}", "${var.private_subnet_id_2}"]

  tags = {
    Name = var.project
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.instance_class
  storage_type           = "gp2"
  identifier             = var.project
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  port                   = 3306
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "04:00-06:00"
  db_subnet_group_name   = aws_db_subnet_group.rds_priv_subnet.name
  vpc_security_group_ids = ["${var.security_group_id}"]

  tags = {
    Name = var.project
  }
}