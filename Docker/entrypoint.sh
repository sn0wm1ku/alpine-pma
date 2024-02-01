#!/bin/sh -eu
nginx -g "daemon off;" &
/workspace/aws-host-tunnel >>/proc/1/fd/2 &
while [ -z "$AWS_RDS_ENDPOINT" ]; do
  sleep 1
done
RDS_HOST=$(echo $AWS_RDS_ENDPOINT | jq "(.[] | .Address)" | tr -d '"')
RDS_PORT=$(echo $AWS_RDS_ENDPOINT | jq "(.[] | .Port)")
RDS_VERBOSE="$(echo $RDS_HOST | cut -d '.' -f 1)(RDS)"

if [ -z "$PMA_HOSTS" ]; then
  export PMA_HOST=$RDS_HOST
  export PMA_PORT=$RDS_PORT
else
  export PMA_HOSTS=$PMA_HOSTS,$RDS_HOST
  export PMA_VERBOSES=$PMA_VERBOSES,$RDS_VERBOSE
  export PMA_PORTS=$PMA_PORT,$RDS_PORT
fi
/docker-entrypoint.sh php-fpm &
wait
