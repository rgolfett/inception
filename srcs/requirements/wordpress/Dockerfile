FROM alpine:3.21

RUN apk update && apk add --no-cache \
    php83="8.3.19-r0" \
    php83-fpm="8.3.19-r0" \
    php83-common="8.3.19-r0" \
    php83-curl="8.3.19-r0" \
    php83-dom="8.3.19-r0" \
    php83-exif="8.3.19-r0" \
    php83-fileinfo="8.3.19-r0" \
    php83-mbstring="8.3.19-r0" \
    php83-mysqli="8.3.19-r0" \
    php83-mysqlnd="8.3.19-r0" \
    php83-openssl="8.3.19-r0" \
    php83-pdo="8.3.19-r0" \
    php83-pdo_mysql="8.3.19-r0" \
    php83-pecl-imagick="3.8.0_rc2-r0" \
    php83-xml="8.3.19-r0" \
    php83-zip="8.3.19-r0" \
    php83-phar="8.3.19-r0" \
    wget \
    zip \
    mysql-client

RUN wget -O /tmp/wp-cli-2.12.0.phar https://github.com/wp-cli/wp-cli/releases/download/v2.12.0/wp-cli-2.12.0.phar && \
    echo "ce34ddd838f7351d6759068d09793f26755463b4a4610a5a5c0a97b68220d85c  /tmp/wp-cli-2.12.0.phar" | sha256sum -c - && \
    chmod +x /tmp/wp-cli-2.12.0.phar && mv /tmp/wp-cli-2.12.0.phar /usr/local/bin/wp

RUN mkdir -p /var/log/php83/ && \
    ln -sf /dev/stdout /var/log/php83-fpm.log && \
    ln -sf /dev/stderr /var/log/php83/error.log && \
    ln -sf /usr/bin/php83 /usr/bin/php && \
    adduser -S -G www-data www-data

EXPOSE 9000

COPY ./conf/php-fpm.conf /etc/php83/php-fpm.conf
COPY ./scripts/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm83", "-F", "--force-stderr"]
