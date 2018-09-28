terragrunt {
  terraform {
    // source = "git::git@github.com:screening/ryan-matthew-smith//terraform/apps/vpc?ref=0.1.0"
    source = "../../../../../apps//vpc"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
