terragrunt {
  terraform {
    source = "git::git@github.com:rms1000watt/terragrunt-example//terraform/apps/vpc?ref=0.1.0"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
