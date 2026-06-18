#!bin/sh

# Initializing the database (in /var/lib so it persists between each boot) if it doesn't exist
# And run the user as the daemon mysql
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    
    # Execute temporarily the server (lighter) to configurate the database
    # Using --bootstrap will allow to execute SQL scripts before any privilege or system tables exist
    # Writing SQL instead of executing mysql_secure_installation allows to avoid bugs and root usage
    mariadbd --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
else
    echo "Database already exists"
fi

exec mariadbd --user=mysql