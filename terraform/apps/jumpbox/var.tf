variable "instance_type" {
  description = "Instance type"
  default     = "t2.nano"
}

variable "ip_whitelist" {
  description = "Additional IPs to whitelist"
  default     = [""]
}

variable "volume_size" {
  description = "Volume size on jumpbox"
  default     = 50
}
