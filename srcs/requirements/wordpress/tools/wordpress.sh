#!/bin/bash
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
else
    echo "WordPress is already installed"
fi

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm85 -F