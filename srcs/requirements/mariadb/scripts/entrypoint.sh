#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql

    mariadbd-safe --socket=/tmp/tmp_mysql.sock &
    MYSQL_PID=$!

    while ! mariadb-admin --socket=/tmp/tmp_mysql.sock ping --silent; do
        sleep 0.5
    done

    echo "Init database"

    mariadb --socket=/tmp/tmp_mysql.sock <<-EOF
        CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
        CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
        GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
        FLUSH PRIVILEGES;
EOF
    echo "Init database done"

    mariadb-admin --socket=/tmp/tmp_mysql.sock shutdown
fi

exec $@