resource "local_file" "build_nginx_conf" {
  filename = "${var.install_root}/nginx/etc/nginx/conf.d/build.conf"
  content = <<-EOT
  
  server {
      server_name ${var.domain_build};

      listen 443 ssl;
      ssl_certificate     /etc/letsencrypt/live/${var.domain_build}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${var.domain_build}/privkey.pem;
      ssl_protocols       TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
      ssl_ciphers         HIGH:!aNULL:!MD5;
    
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
      #add_header X-Content-Type-Options nosniff;    # cannot apply now because of open keycloak issue https://issues.redhat.com/browse/KEYCLOAK-17076
      add_header X-XSS-Protection: "1; mode=block";
      
      return 404;
  }

  server {
      server_name jenkins.${var.domain_build};
      
      listen 443 ssl;
      ssl_certificate     /etc/letsencrypt/live/${var.domain_build}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${var.domain_build}/privkey.pem;
      ssl_protocols       TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
      ssl_ciphers         HIGH:!aNULL:!MD5;
    
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
      #add_header X-Content-Type-Options nosniff;    # cannot apply now because of open keycloak issue https://issues.redhat.com/browse/KEYCLOAK-17076
      add_header X-XSS-Protection: "1; mode=block";

      location / {
      
          proxy_set_header        Host $host;
          proxy_set_header        X-Real-IP $remote_addr;
          proxy_set_header        Referer $http_referer;
          proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header        X-Forwarded-Proto $scheme;
      
          set $proxy_uri          http://jenkins:8080;
          proxy_pass              $proxy_uri;
      }
  }
  
  server {
      server_name mvn.${var.domain_build};
      
      listen 443 ssl;
      ssl_certificate     /etc/letsencrypt/live/${var.domain_build}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${var.domain_build}/privkey.pem;
      ssl_protocols       TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
      ssl_ciphers         HIGH:!aNULL:!MD5;
    
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
      #add_header X-Content-Type-Options nosniff;    # cannot apply now because of open keycloak issue https://issues.redhat.com/browse/KEYCLOAK-17076
      add_header X-XSS-Protection: "1; mode=block";

      location / {
      
          proxy_set_header        Host $host;
          proxy_set_header        X-Real-IP $remote_addr;
          proxy_set_header        Referer $http_referer;
          proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header        X-Forwarded-Proto $scheme;
      
          set $proxy_uri          http://mvn:8080;
          proxy_pass              $proxy_uri;
      }
  }
  
  server {
      server_name registry.${var.domain_build};
      
      listen 443 ssl;
      ssl_certificate     /etc/letsencrypt/live/${var.domain_build}/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/${var.domain_build}/privkey.pem;
      ssl_protocols       TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
      ssl_ciphers         HIGH:!aNULL:!MD5;
    
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
      #add_header X-Content-Type-Options nosniff;    # cannot apply now because of open keycloak issue https://issues.redhat.com/browse/KEYCLOAK-17076
      add_header X-XSS-Protection: "1; mode=block";

      location / {
      
          proxy_set_header        Host $host;
          proxy_set_header        X-Real-IP $remote_addr;
          proxy_set_header        Referer $http_referer;
          proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header        X-Forwarded-Proto $scheme;
      
          set $proxy_uri          http://registry:5000;
          proxy_pass              $proxy_uri;
      }
  }
  
  server {
      listen 80;
      server_name *.${var.domain_build};
      
      return 301 https://$host$request_uri;
  }
  
  EOT
}
