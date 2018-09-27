output "id" {
  value = "${aws_security_group.http.id}"
}

output "vpc_id" {
  value = "${var.vpc_id}"
}

output "name" {
  value = "${aws_security_group.http.name}"
}
