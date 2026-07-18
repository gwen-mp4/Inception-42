FROM alpine:3.24

RUN apk --update add --no-cache wget php85 php85-cli php85-mysqli php85-pdo php85-session && \
    (addgroup -S www-data || true) && \
    (adduser -S -D -H -G www-data www-data || true)

RUN mkdir -p /var/www/html/adminer && \
    wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php && \
    chown -R www-data:www-data /var/www/html/adminer && \
    chmod 755 /var/www/html/adminer/index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html/adminer"]