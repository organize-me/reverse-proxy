local opts = {
    ssl_verify    = ngx.var.ssl_verify,
    redirect_uri  = ngx.var.redirect_uri,
    discovery     = ngx.var.discovery,
    client_id     = ngx.var.client_id,
    client_secret = ngx.var.client_secret
}

local res, err = require("resty.openidc").authenticate(opts)

if err then
    ngx.log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

ngx.req.set_header("X-USER", res.id_token.sub)

