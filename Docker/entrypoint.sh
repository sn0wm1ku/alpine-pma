#!/bin/sh\n\
/docker-entrypoint.sh php-fpm
nginx
cd /workspace && ./aws-host-tunnel >>/proc/1/fd/2
wait
