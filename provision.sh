#!/usr/bin/env bash

export AWS_PROFILE=${AWS_PROFILE:-org-x}

wd=$(pwd)

cd "${wd}/ssm"
./provision.sh

cd "${wd}/terraform/orgs/org-x/us-west-2/prod/vpc"
terragrunt init
terragrunt apply

cd "${wd}/terraform/orgs/org-x/us-west-2/prod/rds"
terragrunt init
terragrunt apply

cd "${wd}/jumpbox"
./start.sh
# In separate terminal, run:
./sshuttle.sh

cd "${wd}/sql"
./hydrate.sh

cd "${wd}/jumpbox"
./stop.sh
