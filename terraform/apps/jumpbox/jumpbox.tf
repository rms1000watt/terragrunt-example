module "vm" {
  source  = "rms1000watt/easy-vm/aws"
  version = "0.1.0"

  vpc_id       = "${data.terraform_remote_state.vpc.vpc_id}"
  subnet_id    = "${element(data.terraform_remote_state.vpc.public_subnets, 0)}"
  ssh_password = "${data.aws_ssm_parameter.jumpbox_pass.value}"

  instance_type = "${var.instance_type}"
  volume_size   = "${var.volume_size}"
  ip_whitelist  = ["${var.ip_whitelist}"]
}
