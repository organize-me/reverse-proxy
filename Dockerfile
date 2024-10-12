FROM openresty/openresty:1.21.4.1-0-jammy

# Setup Volume
VOLUME /usr/local/goaccess

# Initalize Volume
RUN mkdir -p /usr/local/goaccess/logs && \
    touch /usr/local/goaccess/logs/access.log && \
    mkdir -p /usr/local/goaccess/html && \
    mkdir -p /var/log/nginx/ && \
    touch /var/log/nginx/error.log

# Static Nginx Configuration
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
# Copy Scripts
COPY lua /usr/local/openresty/nginx/conf/lua


# Install OpenID Connect Library & Dependencies
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-session && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt && \
    /usr/local/openresty/luajit/bin/luarocks install lua-resty-openidc

