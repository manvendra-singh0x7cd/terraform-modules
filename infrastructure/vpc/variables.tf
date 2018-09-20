variable "aws_vpc_cidr" {
  description = "cidr for the aws vpc, the default value is valid cidr, but not allowed in aws vpc."
  default     = "0.0.0.0/0"
}

variable "aws_vpc_public_subnet_lists" {
  type        = "list"
  description = "list of public subnets"
  default     = []
}

variable "aws_vpc_private_subnet_lists" {
  type        = "list"
  description = "list of private subnets"
  default     = []
}

variable "aws_subnets_availability_zones" {
  type        = "list"
  description = "name of the availability zones for the subnet"
}

variable "aws_subnets_public_name_prefix" {
  description = "prefix for the name of public subnet"
  default     = "public"
}

variable "aws_subnets_private_name_prefix" {
  description = "prefix for the name of private subnet"
  default     = "private"
}

variable "tags" {
  type        = "map"
  description = "Map of tags to be assoicated with in vpc"

  default = {
    name = "vpc"
  }
}

variable "enable_nat_gateway" {
  default     = false
  description = "Wheter to Attach a NAT gateway or not "
}
