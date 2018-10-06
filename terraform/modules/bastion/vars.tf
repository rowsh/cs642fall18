variable "vpc_id" {}

variable "subnet_id" {
  type = "list"
}

variable "template" {}

variable "cidr_blocks" {
  type = "list"
}

variable "public_key_path" {}
variable "key_name" {}
