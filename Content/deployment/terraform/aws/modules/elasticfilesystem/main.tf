resource "aws_efs_file_system" "efs" {
  creation_token = var.project

  tags = {
    Name = var.project
  }
}

resource "aws_efs_mount_target" "efsmt" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = ["${var.security_group_id}"]
}

resource "aws_efs_mount_target" "efsmtalternate" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.alternate_subnet_id
  security_groups = ["${var.security_group_id}"]
}