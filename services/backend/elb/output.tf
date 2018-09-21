output "id" {
  value = "${aws_elb.elb.id}"
}

output "arn" {
  value = "${aws_elb.elb.arn}"
}

output "dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "instances" {
  value = "${aws_elb.elb.instances}"
}

output "security_group_id" {
  value = "${aws_elb.elb.source_security_group_id}"
}
