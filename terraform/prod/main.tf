provider "aws" {
  region = "us-east-1"
}

# vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cs642"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "cs642"
  }
}

# bastion host
module "bastion" {
  source           = "../modules/bastion"
  subnet_id        = "${module.vpc.public_subnets}"
  vpc_id           = "${module.vpc.vpc_id}"
  template         = "../prod/config.tpl"
  cidr_blocks      = ["148.166.0.0/16"]
  public_key_path  = "/Users/hgallo/.ssh/henrygallo.pub"
  key_name         = "cs642fall18"
  sec_group_name   = "allow_ssh_shu"
  placement_name   = "bastion"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1
}

# bastion host
module "ansible_targets" {
  source           = "../modules/bastion"
  subnet_id        = "${module.vpc.private_subnets}"
  vpc_id           = "${module.vpc.vpc_id}"
  template         = "../prod/config.tpl"
  cidr_blocks      = ["10.0.102.85/32"]
  public_key_path  = "/Users/hgallo/.ssh/henrygallo.pub"
  key_name         = "cs642fall18Internal"
  sec_group_name   = "internal_ssh"
  placement_name   = "internals"
  max_size         = 7
  min_size         = 1
  desired_capacity = 6
}
