output "public_ip" {
  value = "${module.vm.public_ip}"
}

output "public_dns" {
  value = "${module.vm.public_dns}"
}

output "ssh_cmd" {
  value = "${module.vm.ssh_cmd}"
}
