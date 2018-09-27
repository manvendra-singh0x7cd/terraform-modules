data "aws_region" "current" {}

data "aws_subnet" "selected" {
  id = "${var.elb_subnets[0]}"
}

variable "ELBACCOUNTID" {
  type = "map"

  default = {
    "us-east-1"      = "127311923021"
    "us-east-2"      = "033677994240"
    "us-west-1"      = "027434742980"
    "us-west-2"      = "797873946194"
    "ca-central-1"   = "985666609251"
    "eu-central-1"   = "054676820928"
    "eu-west-1"      = "156460612806"
    "eu-west-2"      = "652711504416"
    "eu-west-3"      = "009996457667"
    "ap-northeast-1" = "582318560864"
    "ap-northeast-2" = "600734575887"
    "ap-northeast-3" = "383597477331"
    "ap-southeast-1" = "114774131450"
    "ap-southeast-2" = "783225319266"
    "ap-south-1"     = "718504428378"
    "sa-east-1"      = "507241528517"
  }
}

resource "aws_s3_bucket" "elb_logs" {
  acl = "private"
}

resource "aws_s3_bucket_policy" "elb_logs_policy" {
  bucket = "${aws_s3_bucket.elb_logs.id}"

  policy = <<POLICY
{
  "Id": "Policy1429136655940",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1429136633762",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.elb_logs.arn}/*",
      "Principal": {
        "AWS": [
          "${var.ELBACCOUNTID[data.aws_region.current.name]}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_elb" "elb" {
  name_prefix = "${var.name_prefix}"

  access_logs = {
    bucket        = "${aws_s3_bucket.elb_logs.id}"
    bucket_prefix = "${var.name_prefix}"
    interval      = "${var.access_logs_intervel}"
    enabled       = "${var.enable_access_logs}"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.http_port_target}"
    instance_protocol = "http"
  }

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = "${var.https_port_target}"
    instance_protocol  = "http"
    ssl_certificate_id = "${var.elb_ssl_certificate_id}"
  }

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_timeout}"
    target              = "${var.elb_health_target}"
    interval            = "${var.elb_interval}"
  }

  security_groups           = ["${aws_security_group.allow_https_and_http.id}"]
  subnets                   = ["${var.elb_subnets}"]
  cross_zone_load_balancing = "${var.elb_cross_zone_loadbalancing}"
  idle_timeout              = "${var.elb_idle_timeout}"
  connection_draining       = "${var.elb_connection_draining}"
  tags                      = "${var.tags}"
}

resource "aws_security_group" "allow_https_and_http" {
  name_prefix = "${var.name_prefix}"
  vpc_id      = "${data.aws_subnet.selected.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${var.tags}"
}
