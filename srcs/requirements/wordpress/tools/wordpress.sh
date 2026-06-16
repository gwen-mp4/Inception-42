#!/bin/bash
set -x #Debug "docker logs <containerName>"

# Check if wp-config.php is already installed
if [ ! -f ./wp-config.php ]; then
    echo "Cleaning the directory before installation..."
    rm -rf /var/www/wordpress/*
    # Install all WordPress files
    wp core download --path=/var/www/wordpress
    # Create a conf with all I need
    wp config create \
        --path=/var/www/wordpress \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb
    # Final installation
    wp core install \
        --path=/var/www/wordpress \
        --url=$DOMAIN_NAME \
        --title="42 Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
else
    echo "WordPress is already installed"
fi

exec php-fpm85 -F