FROM ubuntu:20.04 as sessionmanagerplugin
ADD https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb .
RUN dpkg -i "session-manager-plugin.deb"
FROM phpmyadmin:fpm-alpine
COPY --from=sessionmanagerplugin /usr/local/sessionmanagerplugin/bin/session-manager-plugin /usr/local/bin/
# COPY cert.key /etc/nginx/ssl/
# COPY cert.crt /etc/nginx/ssl/
RUN apk update && apk upgrade && \
    apk add aws-cli --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \
    apk add gcompat git nginx
# RUN echo  -e "server { \n\
#     listen 80 default_server; \n\
#     server_name _; \n\
#     location / { \n\
#     return 301 https://\$host\$request_uri; \n\
#     } \n\
#     } \n\
#     server { \n\
#     listen 443 ssl; \n\
#     server_name localhost; \n\
#     ssl_certificate /etc/nginx/ssl/cert.crt; \n\
#     ssl_certificate_key /etc/nginx/ssl/cert.key; \n\
#     \n\
#     root /var/www/html; \n\
#     index index.php index.html; \n\
#     \n\
#     location / {  \n\
#     try_files \$uri \$uri/ =404; \n\
#     } \n\
#     \n\
#     location ~ \.php$ { \n\
#     fastcgi_pass 127.0.0.1:9000; \n\
#     fastcgi_index index.php; \n\
#     fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name; \n\
#     include fastcgi_params; \n\
#     } \n\
#     } \n" > /etc/nginx/http.d/nginx.conf && cat /etc/nginx/http.d/nginx.conf && \
#     mv /etc/nginx/http.d/default.conf /etc/nginx/http.d/default.conf-disabled && \
#     nginx -t && nginx && \
#     echo -e "#!/bin/sh\n\
#     /docker-entrypoint.sh php-fpm &\n\
#     nginx &\n\
#     cd /workspace && ops/docker/development/sh/aws-host-tunnel >> /proc/1/fd/2 &\n\
#     wait" > /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh
RUN echo  -e "server { \n\
    listen 80 default_server; \n\
    server_name _; \n\
    root /var/www/html; \n\
    index index.php index.html; \n\
    \n\
    location / {  \n\
    try_files \$uri \$uri/ =404; \n\
    } \n\
    \n\
    location ~ \.php$ { \n\
    fastcgi_pass 127.0.0.1:9000; \n\
    fastcgi_index index.php; \n\
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name; \n\
    include fastcgi_params; \n\
    } \n\
    } \n" > /etc/nginx/http.d/nginx.conf && cat /etc/nginx/http.d/nginx.conf && \
    mv /etc/nginx/http.d/default.conf /etc/nginx/http.d/default.conf-disabled && \
    nginx -t && nginx && \
    echo -e "#!/bin/sh\n\
    /docker-entrypoint.sh php-fpm &\n\
    nginx &\n\
    cd /workspace && ops/docker/development/sh/aws-host-tunnel >> /proc/1/fd/2 &\n\
    wait" > /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/bin/sh", "/usr/local/bin/entrypoint.sh" ]