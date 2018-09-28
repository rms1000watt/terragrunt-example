variable "mysql_db" {
  description = "MySQL DB"
  default     = "test"
}

variable "mysql_port" {
  description = "MySQL port"
  default     = "3306"
}

variable "project_name" {
  description = "Project name for RDS"
  default     = ""
}

variable "rds_instance" {
  description = "RDS instance type"
  default     = "db.t2.micro"
}

variable "rds_disk_size" {
  description = "RDS disk size"
  default     = "20"
}

variable "publicly_accessible" {
  description = "Allow this instance to be publicly available"
  default     = false
}

variable "ip_whitelist" {
  description = "Additional IPs to whitelist"
  default     = [""]
}
