resource "aws_security_group" "allow_ssh" {
  #name        = "allow_ssh_shu"
  name        = "${var.sec_group_name}"
  description = "Allow all inbound 22"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${var.cidr_blocks}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    #    prefix_list_ids = ["pl-12c4e678"]
  }
}
