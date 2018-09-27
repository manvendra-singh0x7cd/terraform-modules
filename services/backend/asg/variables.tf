variable "name_prefix" {
  description = "Name prefix for the autoscaling group"
  default     = ""
}

variable "enviornment" {
  description = "type of the enviornment. valid values are prod and dev"
  default     = "dev"
}

variable "max_size" {
  description = "Max size for the auto scaling group"
  default     = 10
}

variable "min_size" {
  description = "Max size for the auto scaling group"
  default     = 2
}

variable "default_cooldown" {
  default = "300"
}

variable "loadbalancer_list" {
  default = []
  type    = "list"
}

variable "health_check_grace_period" {
  description = "time to allow instance to bootup"
  default     = 300
}

variable "health_check_type" {
  description = "type of healthcheck"
  default     = "EC2"
}

variable "enabled_metrices" {
  type        = "list"
  description = "list of metrices to enable for asg"

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupInServiceInstances",
    "GroupTotalInstances",
  ]
}

variable "image_id" {
  default     = ""
  description = "ID of the image"
}

variable "image_type" {
  description = "type of images, options are ubuntu and amazon"
  default     = "ubuntu"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Type of the instance to launch"
}

variable "associate_public_ip_address" {
  default = false
}

variable "user_data" {
  default     = "echo \"fooo\"  "
  description = "User data for the application"
}

variable "enable_moniotring" {
  default     = false
  description = "whether to enable detailed monitoring or not"
}

variable "ebs_optimized" {
  description = "whether the instance is ebs optimized or not"
  default     = true
}

variable "volume_size" {
  description = "size for the EBS volume"
  default     = 20
}

variable "volume_type" {
  description = "Type of the volume"
  default     = "gp2"
}

variable "delete_on_termination" {
  default = true
}

variable "placement_tenancy" {
  default = "default"
}

variable "enable_lb" {
  description = "Whether to add an elb to security group or not."
  default     = false
}
