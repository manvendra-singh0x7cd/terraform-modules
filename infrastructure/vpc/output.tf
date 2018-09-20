output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc_public_subnet_lists" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "vpc_private_subnet_lists" {
  value = "${aws_subnet.private_subnet.*.id}"
}
