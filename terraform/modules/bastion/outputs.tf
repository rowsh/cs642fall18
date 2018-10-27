data "aws_instances" "ec2s" {
  instance_tags {
    automated = "terraform"
  }

  depends_on = ["aws_autoscaling_group.bar"]
}

output "private-ips" {
  value = "${data.aws_instances.ec2s.private_ips}"
}

output "public-ips" {
  value = "${data.aws_instances.ec2s.public_ips}"
}
