data "aws_ssm_parameter" "mysql_user" {
  name = "mysql-user"
}

data "aws_ssm_parameter" "mysql_pass" {
  name = "mysql-pass"
}
