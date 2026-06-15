FROM alpine:3.24

RUN apk update && apk upgrade && apk add --no-cache \
    wget \
    curl \
    bash \
    php \
    php-cgi \
    php-mysqli \
    php-fpm \
    php-pdo \
	php-gd \
    php-cli \
	php-mbstring \
	redis \
	php-redis

# Installing wp_cli to do communicate with WordPress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-clir.phar \
    && wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php85/php-fpm.d/www.conf

RUN mkdir -p /run/php

# Copy script and execute it locally on the PC
COPY ./tools/wordpress.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/sbin/php-fpm85", "-F"]