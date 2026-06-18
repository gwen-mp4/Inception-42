FROM alpine:3.24

RUN apk update && apk upgrade && apk add --no-cache \
    mariadb \
    mariadb-client

COPY ./conf/mariadbd.cnf /etc/my.cnf.d/

# Allowing mysql daemon to run by changing ownership
RUN mkdir -p /var/run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

COPY ./tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]