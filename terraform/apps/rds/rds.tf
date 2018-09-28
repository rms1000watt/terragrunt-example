module "rds_sg" {
  source  = "rms1000watt/easy-sg/aws"
  version = "0.1.0"

  vpc_id    = "${data.terraform_remote_state.vpc.vpc_id}"
  whitelist = ["${data.terraform_remote_state.vpc.public_subnets_cidr_blocks}", "${var.ip_whitelist}"]
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.21.0"

  identifier = "${local.project_name}"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  name     = "${var.mysql_db}"
  username = "${data.aws_ssm_parameter.mysql_user.value}"
  password = "${data.aws_ssm_parameter.mysql_pass.value}"
  port     = "${var.mysql_port}"

  vpc_security_group_ids = ["${module.rds_sg.id}"]
  subnet_ids             = ["${data.terraform_remote_state.vpc.private_subnets}"]
  family                 = "mysql5.7"
  major_engine_version   = "5.7"
  maintenance_window     = "Mon:00:00-Mon:03:00"
  backup_window          = "03:00-06:00"
  publicly_accessible    = "${var.publicly_accessible}"

  enabled_cloudwatch_logs_exports = ["error", "slowquery"]

  tags {
    Environment = "${var.environment}"
  }
}
