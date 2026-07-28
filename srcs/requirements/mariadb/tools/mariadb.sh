#!/bin/sh

if [ -f "/run/secrets/mariadb_user_password" ] && [ -f "/run/secrets/mariadb_root_password" ]; then
    MYSQL_PASSWORD=$(cat /run/secrets/mariadb_user_password)
    MYSQL_ROOT_PASSWORD=$(cat /run/secrets/mariadb_root_password)
else
    echo "Error : One of the required secrets is nowhere to be found !"
    exit 1
fi

# Initializing the database (in /var/lib so it persists between each boot) if it doesn't exist
# And run the user as the daemon mysql
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    # Execute temporarily the server to configure the database
    mariadbd --user=mysql --datadir=/var/lib/mysql & pid="$!"
    until mariadb-admin ping --silent; do
			echo "Waiting for MariaDB to start..."
			sleep 2
	done

	echo "Configurating database..."
    mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='root' AND Host='%';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

# Stop the temporary MariaDB instance
kill "$pid"
wait "$pid"

else
    echo "Database already exists"
fi

# Delete the lock file if it exists and if none of MariaDB instance is active
if [ -f /var/lib/mysql/aria_log_control ]; then
    rm -f /var/lib/mysql/aria_log_control
fi

echo "Starting MariaDB..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql