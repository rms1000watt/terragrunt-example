data "aws_ssm_parameter" "jumpbox_pass" {
  name = "jumpbox-pass"
}
