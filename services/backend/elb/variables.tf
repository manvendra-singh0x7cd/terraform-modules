variable "name_prefix" {
  description = "Prefix for the elb name"
}

variable "enable_access_logs" {
  description = "enable access logs for the elb"
  default     = false
}

variable "access_logs_intervel" {
  default = 5
}

variable "http_port_target" {
  description = "Forward the http traffic to this port in backend"
  default     = 80
}

variable "https_port_target" {
  description = "Forward the https traffic to this port in backend"
  default     = 80
}

variable "elb_ssl_certificate_id" {
  description = "ARN of SSL certificates that are uploaded on AWS Acm"
}

variable "elb_healthy_threshold" {
  description = "The number of checks before the instance is declared healthy"
  default     = 2
}

variable "elb_unhealthy_threshold" {
  description = "The number of checks before the instance is declared healthy"
  default     = 3
}

variable "elb_health_target" {
  description = "target for the health chekc. Valid pattern is \"${PROTOCOL}:${PORT}${PATH}\""
  default     = "HTTP:80/"
}

variable "elb_timeout" {
  description = "the timeout period for the healthchecks"
  default     = 3
}

variable "elb_interval" {
  description = "the interval between checks"
  default     = 30
}


variable "elb_subnets" {
  type        = "list"
  description = "A list of subnet id to attach to elb"
  default = []
}

variable "elb_cross_zone_loadbalancing" {
  default = true
}

variable "elb_idle_timeout" {
  description = "maximum time to wait for a connection to be idel state"
  default     = 60
}

variable "elb_connection_draining" {
  description = "whether connection draningi is disabled or enabled"
  default     = true
}

variable "tags" {
  type = "map"
  description = "Tags to apply on elb"
  default = {}
}
