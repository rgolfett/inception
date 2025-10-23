FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/www/html /run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN if [ ! -f /etc/nginx/ssl/server.crt ]; then \
        openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/server.key \
        -out /etc/nginx/ssl/server.crt \
        -subj "/C=FR/ST=France/L=Lyon/O=42/OU=Student/CN=rgolfett.42.fr"; \
    fi

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
