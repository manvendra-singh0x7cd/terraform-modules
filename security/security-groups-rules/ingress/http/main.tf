variable "vpc_id" {}

resource "aws_security_group" "http" {
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "http_rule" {
  count             = "${var.source_security_group_id == "" ? 1: 0}"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.http.id}"
  cidr_blocks       = "${var.cidr_blocks}"
  description       = "${var.description}"
}

resource "aws_security_group_rule" "http" {
  count                    = "${var.source_security_group_id == "" ? 0: 1}"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.http.id}"
  source_security_group_id = "${var.source_security_group_id}"
  description              = "${var.description}"
}
