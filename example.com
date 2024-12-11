server {
    server_name $SERVER_NAME $ALT_SERVER_NAME;

    listen [::]:443 ssl ipv6only=on; 
    listen 443 ssl; 

    # Can be overwritten by certbot
    ssl_certificate /home/$DJANGO_USER/django/$APP_NAME/env/certificate.pem ;
    ssl_certificate_key /home/$DJANGO_USER/django/$APP_NAME/env/private_key.pem ; 

    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    }

    location = /favicon.ico { access_log off; log_not_found off; }

    # This must match Django's STATIC_URL
    location /static/ {
        # This must match Django's STATIC_ROOT
        root /home/$DJANGO_USER/django/$APP_NAME;
    }

    location / {
        include proxy_params;
        proxy_pass http://localhost:8000;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name $SERVER_NAME $ALT_SERVER_NAME;

    location / {
        return 301 https://$server_name$request_uri;
    }
}

