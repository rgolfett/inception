FROM alpine:3.21

RUN apk update \
&& apk add mariadb \
mariadb-client \
mariadb-server-utils

EXPOSE 3306

COPY ./conf/my.cnf /etc/my.cnf

COPY ./scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mariadbd", "--user=mysql", "--datadir=/var/lib/mysql", "--socket=/tmp/mysql.sock"]