#!/usr/bin/env bash

if [[ -z $ORG_NAME ]]; then
  echo "ERROR: \$ORG_NAME not defined"
  exit 1
fi

if [[ -z $AWS_PROFILE ]]; then
  echo "ERROR: \$AWS_PROFILE not defined"
  exit 1
fi

if [[ -z $AWS_REMOTE_STATE_REGION ]]; then
  echo "ERROR: \$AWS_REMOTE_STATE_REGION not defined: try export \$AWS_REMOTE_STATE_REGION=us-west-2"
  exit 1
fi

org_name="$ORG_NAME"
aws_profile="$AWS_PROFILE"
aws_remote_state_region="$AWS_REMOTE_STATE_REGION"


create-org() {
  if [[ ! -d $org_name ]]; then
    mkdir "$org_name"
  fi

  cd "$org_name" || exit 1

  cat << EOF > "org.tfvars"
aws_profile = "$aws_profile"

org_name = "$org_name"

aws_remote_state_region = "$aws_remote_state_region"
EOF

  cat << EOF > "terraform.tfvars"
terragrunt {
  remote_state {
    backend = "s3"

    config {
      profile        = "${org_name}"
      bucket         = "terraform-state-${org_name}-\${get_aws_account_id()}"
      region         = "${aws_remote_state_region}"
      dynamodb_table = "terraform-locks"
      key            = "\${path_relative_to_include()}/terraform.tfstate"
      encrypt        = true
    }
  }

  terraform {
    extra_arguments "comands_that_need_vars" {
      commands = ["init", "\${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "\${get_tfvars_dir()}/\${find_in_parent_folders("org.tfvars")}",
        "\${get_tfvars_dir()}/\${find_in_parent_folders("env.tfvars")}",
        "\${get_tfvars_dir()}/\${find_in_parent_folders("region.tfvars")}",
      ]
    }
  }
}
EOF

  cd ..
}

create-org
