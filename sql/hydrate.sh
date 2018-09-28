#!/usr/bin/env bash

set -e

export AWS_REGION=us-west-2
export AWS_PROFILE=${AWS_PROFILE:-org-x}

MYSQL_DB=test
MYSQL_PORT=3306
echo "Getting mysql host"
MYSQL_HOST=$(aws rds describe-db-instances | jq '.DBInstances[].Endpoint.Address' | tr -d '"')
echo "Getting mysql user"
MYSQL_USER=$(aws ssm get-parameter --name mysql-user | jq '.Parameter.Value' | tr -d '"')
echo "Getting mysql password"
MYSQL_PASS=$(aws ssm get-parameter --name mysql-pass | jq '.Parameter.Value' | tr -d '"')

echo "Run mysql commands to hydrate MYSQL"
exit 1
