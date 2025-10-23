FROM alpine:3.22

RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-common \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-mysqli \
    php83-mysqlnd \
    php83-openssl \
    php83-pdo \
    php83-pdo_mysql \
    php83-pecl-imagick \
    php83-xml \
    php83-zip \
    php83-phar \
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
