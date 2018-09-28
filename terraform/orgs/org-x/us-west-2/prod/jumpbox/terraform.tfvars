terragrunt {
  terraform {
    // source = "git::git@github.com:screening/ryan-matthew-smith//terraform/apps/jumpbox?ref=0.1.0"
    source = "../../../../../apps//jumpbox"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
