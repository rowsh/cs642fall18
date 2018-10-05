resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_shu"
  description = "Allow all inbound 22"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["148.166.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

    #    prefix_list_ids = ["pl-12c4e678"]
  }
}
