#!/usr/bin/env bash

MYSQL_DB=test
MYSQL_PORT=3306
echo "Getting mysql host"
MYSQL_HOST=$(aws rds describe-db-instances | jq '.DBInstances[].Endpoint.Address' | tr -d '"')
echo "Getting mysql user"
MYSQL_USER=$(aws ssm get-parameter --name mysql-user | jq '.Parameter.Value' | tr -d '"')
echo "Getting mysql password"
MYSQL_PASS=$(aws ssm get-parameter --name mysql-pass | jq '.Parameter.Value' | tr -d '"')

echo
echo "Connecting to host: ${MYSQL_HOST}"
echo "docker run -it --rm mysql:5 mysql -u${MYSQL_USER} -p${MYSQL_PASS} -h${MYSQL_HOST}"
docker run -it --rm mysql:5 mysql -u${MYSQL_USER} -p${MYSQL_PASS} -h${MYSQL_HOST}
