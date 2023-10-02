#!/bin/bash

docker run \
  -d \
  --name organize-me-nginx \
  --network organize_me_network \
  --ip 172.22.0.10 \
  --restart unless-stopped \
  -v $ORGANIZE_ME_HOME/nginx/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
  -v $ORGANIZE_ME_HOME/nginx/lua:/usr/local/openresty/nginx/conf/lua \
  -v $ORGANIZE_ME_HOME/letsencrypt/etc/letsencrypt:/etc/letsencrypt \
  -v $ORGANIZE_ME_HOME/letsencrypt/var/lib/letsencrypt:/var/lib/letsencrypt \
  -p 80:80 \
  -p 443:443 \
  organize-me/nginx
