locals {
  path_root_list = "${split("/", path.root)}"
  path_root_len  = "${length(local.path_root_list)}"
  parent_dir     = "${element(local.path_root_list, local.path_root_len - 1)}"
  project_name   = "${var.project_name != "" ? var.project_name : local.parent_dir}"
}
