resource "aws_db_subnet_group" "kpmg-challenge-rds-subnet-group" {
  name = format("kpmg-challenge-%s-%s-rds-subnet-group", var.account_environment, var.kpmg-challenge_region)
  subnet_ids = var.private_subnets
  description = "kpmg-challenge Mysql Subnet group"
  tags = {
    Name = format("kpmg-challenge-%s-%s-rds-subnet-group", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_rds_cluster_parameter_group" "kpmg-challenge-rds-cluster-param" {
  name = format("kpmg-challenge-%s-%s-rds-cluster", var.account_environment, var.kpmg-challenge_region)
  description = format("kpmg-challenge Aurora DB %s ", var.account_environment)
  family = "aurora-mysql5.7"
  parameter {
    name = "log_bin_trust_function_creators"
    value = "1"
  }
  tags = {
    Name = format("kpmg-challenge-%s-%s-rds-cluster", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_db_parameter_group" "kpmg-challenge-rds-cluster-instance-param" {
  name = format("kpmg-challenge-%s-%s-cluster-instance", var.account_environment, var.kpmg-challenge_region)
  description = format("kpmg-challenge Aurora DB instance %s", var.account_environment)
  family = "aurora-mysql5.7"
  parameter {
    name = "log_bin_trust_function_creators"
    value = "1"
  }
  tags = {
    Name = format("kpmg-challenge-%s-%s-cluster-instance", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_rds_cluster_instance" "kpmg-challenge-rds-cluster-instance" {
  count = var.rds_cluster_instance_number 
  identifier = format("kpmg-challenge-%s-%s-cluster-db-%s", var.account_environment, var.kpmg-challenge_region, count.index + 1)
  cluster_identifier = aws_rds_cluster.kpmg-challenge-rds-cluster.id
  instance_class = var.rds_cluster_instance_class
  db_parameter_group_name = aws_db_parameter_group.kpmg-challenge-rds-cluster-instance-param.id
  auto_minor_version_upgrade = true
  publicly_accessible = false
  engine = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.07.2"
  tags = {
    Name = format("kpmg-challenge-%s-%s-cluster-db-%s", var.account_environment, var.kpmg-challenge_region, count.index + 1)
  }
}

resource "aws_rds_cluster" "kpmg-challenge-rds-cluster" {
  cluster_identifier = format("kpmg-challenge-%s-%s-kpmg-challenge-cluster", var.account_environment, var.kpmg-challenge_region)
  master_username = "kpmg-challenge"
  master_password = random_password.rds_password.result
  engine = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.07.2"
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.kpmg-challenge-rds-cluster-param.name
  preferred_maintenance_window = "Sun:04:00-Sun:06:00"
  preferred_backup_window = "02:00-04:00"
  backup_retention_period = 14
  storage_encrypted = var.rds_storage_encrypted
  port = 3306
  db_subnet_group_name = aws_db_subnet_group.kpmg-challenge-rds-subnet-group.name
  deletion_protection = true
  skip_final_snapshot = true
  vpc_security_group_ids = [
    aws_security_group.kpmg-challenge-rds-server-sg.id
  ]
  tags = {
    Name = format("kpmg-challenge-%s-%s-kpmg-challenge-cluster", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_security_group" "kpmg-challenge-rds-client-sg" {
  vpc_id = var.vpc_id
  name = format("kpmg-challenge-%s-%s-client-db", var.account_environment, var.kpmg-challenge_region)
  description = "RDS client kpmg-challenge"
  tags = {
    Name = format("kpmg-challenge-%s-%s-client-db", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_security_group_rule" "kpmg-challenge-rds-client-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.kpmg-challenge-rds-client-sg.id
}

resource "aws_security_group" "kpmg-challenge-rds-server-sg" {
  vpc_id = var.vpc_id
  name = format("kpmg-challenge-%s-%s-server-db", var.account_environment, var.kpmg-challenge_region)
  description = "RDS server kpmg-challenge"
  tags = {
    Name = format("kpmg-challenge-%s-%s-server-db", var.account_environment, var.kpmg-challenge_region)
  }
}

resource "aws_security_group_rule" "kpmg-challenge-rds-server-client-in" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = aws_security_group.kpmg-challenge-rds-server-sg.id
  source_security_group_id = aws_security_group.kpmg-challenge-rds-client-sg.id
  description = "Accept from DB client security group"
}

resource "aws_security_group_rule" "kpmg-challenge-rds-server-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.kpmg-challenge-rds-server-sg.id
}

resource "random_password" "rds_password" {
  length = 12
  special = true
  override_special = "!#()-[]<>\""
}
