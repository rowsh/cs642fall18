data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "ec2_template" {
  template = "${file("${var.template}")}"

#  vars {
#    cluster_name = "${var.cluster_name}"
#  }
}

resource "aws_launch_configuration" "as_conf" {
  image_id        = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t2.micro"
  user_data       = "${data.template_file.ec2_template.rendered}"
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  key_name        = "cs642fall18"

  lifecycle {
    create_before_destroy = true
  }
}
