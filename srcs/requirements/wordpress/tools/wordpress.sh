#!/bin/sh
set -x #Debug "docker logs <containerName>"

until mariadb-admin ping \
	-h "$MYSQL_HOSTNAME" \
	-u "$MYSQL_USER" \
	-p"$MYSQL_PASSWORD" \
	--silent
do
	echo "Waiting for MariaDB..."
	sleep 2
done

# Check if wp-config.php is already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "Cleaning the directory before installation..."
    rm -rf *.*
    # Install all WordPress files
    wp core download --allow-root
    # Creating our wp-config.php
    wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="$MYSQL_HOSTNAME" \
		--allow-root
    # Final installation
    wp core install \
        --path=/var/www/html \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # ---BONUS (redis)---
    wp config set WP_REDIS_HOST "redis" --type=constant --allow-root
    wp config set WP_REDIS_PORT 6379 --type=constant --allow-root
    wp config set WP_CACHE true --type=constant --allow-root
    # Avoid mixing up caches if same multiple pages are open
    wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
    # Using "phpredis" instead of "predis" for speed and performance (for PHP->Redis)
    wp config set WP_REDIS_CLIENT phpredis --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
else
    echo "WordPress is already installed"
fi

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm85 -F