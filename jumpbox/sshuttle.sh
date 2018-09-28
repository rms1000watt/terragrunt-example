#!/usr/bin/env bash

set -e

export AWS_PROFILE=${AWS_PROFILE:-org-x}

clean() {
  rm terraform.tfstate
}

trap clean EXIT

aws s3 cp s3://terraform-state-org-x-401319614350/us-west-2/prod/jumpbox/terraform.tfstate terraform.tfstate
PUBLIC_IP=$(jq '.modules[0].outputs.public_ip.value' < terraform.tfstate | tr -d '"')
echo "Getting Jumpbox Password"
PASSWORD=$(aws ssm get-parameter --name jumpbox-pass | jq '.Parameter.Value' | tr -d '"')

echo "Adding host to known_hosts"
ssh-keyscan "$PUBLIC_IP" 2>/dev/null  | grep 'nistp256' >> ~/.ssh/known_hosts

echo "Trying to sshuttle to: ${PUBLIC_IP}"
sshuttle -e "sshpass -p ${PASSWORD} ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no" --dns -r ubuntu@${PUBLIC_IP} 0/0
