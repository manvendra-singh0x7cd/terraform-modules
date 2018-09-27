variable "subnet_lists" {
  type        = "list"
  description = "List of subnets to attach on asg"
}

resource "aws_autoscaling_group" "asg" {
  name_prefix               = "${var.name_prefix != "" ? var.name_prefix: "terraform-asg"}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  vpc_zone_identifier       = ["${var.subnet_lists}"]
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  default_cooldown          = "${var.default_cooldown}"
  launch_configuration      = "${aws_launch_configuration.asgconfig.name}"
}

resource "aws_autoscaling_attachment" "asg-elb" {
  count                  = "${var.enable_lb}"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  elb                    = "${var.loadbalancer_list[0]}"
}
