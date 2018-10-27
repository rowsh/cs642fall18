output "public-ips" {
  value = "${module.bastion.public-ips}"
}

output "private-ips" {
  value = "${module.bastion.private-ips}"
}
