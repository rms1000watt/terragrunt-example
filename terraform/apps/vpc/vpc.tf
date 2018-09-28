module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.40.0"

  name = "${var.org_name}-${var.environment}"

  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = "${var.enable_nat_gateway}"
  single_nat_gateway   = "${var.single_nat_gateway}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"

  tags {
    Environment = "${var.environment}"
  }
}
