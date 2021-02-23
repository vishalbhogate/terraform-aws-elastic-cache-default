variable "name" {
  description = "Name prefix for the resources of this stack"
}

variable "enabled" {
  default     = false
  description = "Create elastic cache cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "vpn_cidr" {
  type        = list(string)
  description = "VPC CIDR ID"
}
variable "source_security_group_id" {
  default     = ""
  description = "Source Security group ID"
}
variable "subnet_ids" {
  type        = list(string)
  description = "AWS subnet ids"
}

variable "cluster_size" {
  type        = number
  default     = 1
  description = "Cluster size"
}

variable "node_type" {
  type        = string
  default     = "cache.t2.micro"
  description = "Elastic cache instance type"
}

variable "engine" {
  type        = string
  description = "Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis"
}

variable "engine_version" {
  type        = string
  description = " Version number of the cache engine to be used"
}

variable "notification_topic_arn" {
  type        = string
  default     = ""
  description = "Notification topic arn"
}

variable "alarm_cpu_threshold_percent" {
  type        = number
  default     = 75
  description = "CPU threshold alarm level"
}

variable "parameter_group_name" {
  default     = ""
  description = "(optional) describe your variable"
}

variable "alarm_memory_threshold_bytes" {
  type        = number
  default     = 10000000 # 10MB
  description = "Alarm memory threshold bytes"
}

variable "alarm_sns_topics" {
  default     = []
  description = "(optional) describe your variable"
}
variable "alarm_actions" {
  type        = list(string)
  default     = []
  description = "Alarm actions"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
}

variable "zone_id" {
  type        = string
  default     = ""
  description = "Route53 DNS Zone ID"
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}