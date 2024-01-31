#!/bin/sh -eu
/docker-entrypoint.sh php-fpm &
nginx &
/workspace/aws-host-tunnel >>/proc/1/fd/2 &
wait
