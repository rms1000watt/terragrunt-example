output "db" {
  value = "${var.mysql_db}"
}

output "host" {
  value = "${module.rds.this_db_instance_address}"
}

output "port" {
  value = "${var.mysql_port}"
}
