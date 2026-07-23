# User documentation

This project provides a ready-to-use web stack for hosting a WordPress site with HTTPS, a database, caching, FTP access, and basic administration tools.

## 1. What services are included?

The stack provides:

- A website served by Nginx over HTTPS
- A WordPress administration panel
- A MariaDB database for the site content
- Redis caching for better WordPress performance
- An FTP service for uploading or managing files in the web root
- Adminer for database administration
- cAdvisor for container monitoring

## 2. Start and stop the project

From the project root, use:

- make

This starts all services in the background.

To stop the services:

- make down

To see the current container state:

- make status

To view logs:

- make logs

## 3. Access the website and administration tools

Once the stack is running, use the following addresses:

- Main website: https://gwen.42.fr/
- WordPress admin panel: https://gwen.42.fr/wp-admin/
- Adminer: https://gwen.42.fr/adminer/
- cAdvisor: https://gwen.42.fr/cadvisor/
- Static page: https://gwen.42.fr/static/

If the domain name does not resolve on your machine, add it to /etc/hosts:

- 127.0.0.1 gwen.42.fr

## 4. Locate and manage credentials

The credentials are defined in srcs/.env.

The most important values are:

- WordPress admin account: WP_ADMIN_USER and WP_ADMIN_PASSWORD
- WordPress admin email: WP_ADMIN_EMAIL
- MariaDB database user: MYSQL_USER and MYSQL_PASSWORD
- MariaDB root password: MYSQL_ROOT_PASSWORD
- FTP access: FTP_USER and FTP_PASS

If you need to change them, edit srcs/.env and restart the stack.

## 5. Check that everything is running correctly

You can verify the project in several ways:

- Run make status to see the containers.
- Open the website in your browser.
- Open the WordPress admin page and log in with the credentials from srcs/.env.
- Open Adminer and cAdvisor to confirm the extra services are reachable.
- Use make logs if you want to inspect errors.

A healthy stack should show all containers in the Running state and the website should load over HTTPS.

## 6. FTP access

The FTP service is configured for the web root directory.

Typical connection details:

- Host: your Docker host or localhost
- Port: 21
- User: the value of FTP_USER in srcs/.env
- Password: the value of FTP_PASS in srcs/.env

A client such as FileZilla or lftp can be used to connect.

## 7. Notes for administrators

- The website data is stored on the host in /home/gwen/data/wordpress.
- The database data is stored on the host in /home/gwen/data/mariadb.
- If you want to fully reset the project, use make fclean. This removes containers, volumes, and the stored data directories.
