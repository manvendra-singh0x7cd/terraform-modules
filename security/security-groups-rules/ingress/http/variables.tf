variable "cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "source_security_group_id" {
  default = ""
}

variable "description" {
  default = "Allow HTTP"
}

variable "tags" {
  type = "map"
}
