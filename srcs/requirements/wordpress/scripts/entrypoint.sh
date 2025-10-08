#!/bin/sh

WORDPRESS_SHA1=7be6342c420ea47c395506f0d7f49d20272a748e
WORDPRESS_LINK="https://wordpress.org/wordpress-6.8.2.zip"

if [ -f /var/www/wp-config.php ]; then
    echo "Wordpress Installed";
else
    wget -O /tmp/wordpress.zip $WORDPRESS_LINK
    if echo "$WORDPRESS_SHA1 */tmp/wordpress.zip"| sha1sum -c -; then
        mkdir -p /var/www/ && unzip /tmp/wordpress.zip -d /tmp
        mv /tmp/wordpress/* /var/www/
        rm -rf /tmp/wordpress /tmp/wordpress.zip
    else
        echo "wordpress.zip checksum is invalid"
        exit 1
    fi

    chown -R www-data:www-data /var/www/

    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb:3306 --path=/var/www/ --skip-check

    wp core install --url=https://$DOMAIN_NAME --title="Mon Super Wordpress!" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --path=/var/www/ --skip-email

    wp plugin delete akismet hello --path=/var/www/

    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASS --path=/var/www/
fi

exec $@
