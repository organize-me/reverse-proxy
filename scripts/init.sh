#!/bin/sh


mkdir -p $ORGANIZE_ME_HOME/nginx/lua
cp -r ./lua/ $ORGANIZE_ME_HOME/nginx/

cat nginx.conf | param-filter.sh > $ORGANIZE_ME_HOME/nginx/nginx.conf
