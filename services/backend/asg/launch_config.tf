variable "key_name" {
  description = "Key Pair to attach"
}

variable "iam_instance_profile" {
  description = "Instance profile to attach on launched ec2 instance names"
}

variable "security_groups" {
  description = "List of security groups to attach on instance"
  type        = "list"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_launch_configuration" "asgconfig" {
  name_prefix                 = "${var.name_prefix != "" ? var.name_prefix: "terraform-config"}"
  image_id                    = "${var.image_id != "" ? var.image_id: data.aws_ami.ubuntu.id}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${var.security_groups}"]
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data}"
  enable_monitoring           = "${var.enable_moniotring}"
  ebs_optimized               = "${var.ebs_optimized}"
  iam_instance_profile        = "${var.iam_instance_profile}"

  root_block_device = {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
