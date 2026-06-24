FROM alpine:3.24

RUN apk update && apk upgrade && apk add --no-cache \
    wget \
    curl \
    bash \
    php85 \
    php85-cgi \
    php85-mysqli \
    php85-fpm \
    php85-pdo \
	php85-gd \
    php85-cli \
	php85-mbstring \
    php85-json \
    php85-openssl \
    php85-phar \
	redis \
	php85-redis \
    mariadb-client

RUN rm -f /usr/local/bin/wp

# Installing wp_cli to do communicate with WordPress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php85/php-fpm.d/www.conf

RUN mkdir -p /run/php

# Allocating more space otherwise there'll no  enough space
RUN echo "memory_limit = 256M" >> /etc/php85/php.ini

WORKDIR /var/www/html

EXPOSE 9000

# Copy script and execute it locally on the PC
COPY ./tools/wordpress.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]