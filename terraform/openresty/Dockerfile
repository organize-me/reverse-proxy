FROM openresty/openresty:1.31.1.1-jammy

# Initalize Volume
RUN mkdir -p /usr/local/goaccess/logs && \
    touch /usr/local/goaccess/logs/access.log && \
    mkdir -p /usr/local/goaccess/html && \
    mkdir -p /usr/local/goaccess/db && \
    touch /usr/local/goaccess/db/

# Static Nginx Configuration
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
# Copy Scripts
COPY lua /usr/local/openresty/nginx/conf/lua


# Install OpenID Connect Library & Dependencies
RUN opm get bungle/lua-resty-session && \
    opm get burnes/lua-resty-openidc
