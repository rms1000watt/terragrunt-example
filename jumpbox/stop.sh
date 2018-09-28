#!/usr/bin/env bash

export AWS_PROFILE=${AWS_PROFILE:-org-x}

cd ../terraform/orgs/org-x/us-west-2/prod/jumpbox

terragrunt destroy -auto-approve
