FROM openresty/openresty:1.21.4.1-0-jammy

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-session
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-openidc

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install certbot && \
    apt-get -y install python3-certbot-nginx

