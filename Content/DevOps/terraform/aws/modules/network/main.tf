resource "aws_vpc" "vpc" {
  cidr_block           = "172.30.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.30.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "alternate" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.30.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone_alternate

  tags = {
    Name = var.project
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.project
  }
}

resource "aws_route_table" "public-crt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.project
  }
}

resource "aws_route_table_association" "crta-public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-crt.id
}

resource "aws_route_table_association" "crta-alternate" {
  subnet_id      = aws_subnet.alternate.id
  route_table_id = aws_route_table.public-crt.id
}

resource "aws_security_group" "app" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.project
  }
}

resource "aws_security_group_rule" "nfs" {
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
}

resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.project
  }
}

resource "aws_security_group_rule" "mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app.id
  security_group_id        = aws_security_group.rds.id
}

resource "aws_subnet" "private_rds_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.30.2.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "private_rds_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.30.3.0/24"
  availability_zone = var.availability_zone_alternate

  tags = {
    Name = var.project
  }
}