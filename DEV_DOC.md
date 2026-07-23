# Developer documentation

This project builds a small Docker-based web stack around WordPress, Nginx, MariaDB, Redis, FTP, Adminer, and cAdvisor. The entry point is the compose file in srcs/docker-compose.yaml and the Makefile at the repository root.

## 1. Architecture overview

The stack is composed of the following services:

- Nginx: serves the site over HTTPS, forwards PHP requests to WordPress, and exposes the Adminer and cAdvisor web interfaces under /adminer/ and /cadvisor/.
- WordPress: runs PHP-FPM with the WordPress files installed in /var/www/html.
- MariaDB: stores the WordPress database.
- Redis: provides object caching for WordPress.
- vsftpd: exposes an FTP service for the web root.
- Adminer: provides a lightweight database administration web interface.
- cAdvisor: exposes container metrics and resource usage.

## 2. Prerequisites

Before starting the project, make sure the following tools are available on the host:

- Docker Engine
- Docker Compose v2
- make
- sudo access for the project’s directory creation and cleanup steps

The project expects a host mapping for the domain name used in the configuration. By default, the domain is gwen.42.fr. If you want to access it locally, add a line such as the following to /etc/hosts:

- 127.0.0.1 gwen.42.fr

## 3. Environment configuration

The main configuration values are stored in srcs/.env.

Important variables include:

- MYSQL_HOSTNAME, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD
- DOMAIN_NAME, WP_TITLE, WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL
- FTP_USER, FTP_PASS

Do not commit this file to version control. It is used by the Docker containers at startup.

## 4. Build and launch from scratch

From the repository root, run:

- make

This target performs the following steps:

1. Creates the host directories /home/gwen/data/wordpress and /home/gwen/data/mariadb if they do not exist.
2. Sets ownership for the mounted data directories.
3. Starts the full stack with Docker Compose.

Equivalent manual command:

- docker compose -f srcs/docker-compose.yaml up -d --build

To stop the stack:

- make down

The corresponding compose command is:

- docker compose -f srcs/docker-compose.yaml down

## 5. Useful Makefile targets

- make: create directories and start everything
- make up: start the stack
- make down: stop the stack
- make status: show container status
- make logs: show logs from all services
- make clean: remove containers and related resources
- make fclean: remove everything, including volumes and the host data directories

## 6. Managing containers and logs

Useful commands:

- docker compose -f srcs/docker-compose.yaml ps
- docker compose -f srcs/docker-compose.yaml logs
- docker compose -f srcs/docker-compose.yaml logs nginx
- docker exec -it wordpress sh
- docker exec -it mariadb sh
- docker exec -it redis sh

If you need to inspect the WordPress installation inside the container, use:

- docker exec -it wordpress sh

Inside the container, the WordPress files are installed under /var/www/html.

## 7. Data persistence and storage

The project uses bind-mounted host directories so that data survives container restarts and rebuilds:

- /home/gwen/data/wordpress is mounted into the WordPress, Nginx, FTP, and Redis containers at /var/www/html.
- /home/gwen/data/mariadb is mounted into the MariaDB container at /var/lib/mysql.

This means:

- WordPress files, themes, uploads, and plugins are stored in /home/gwen/data/wordpress.
- MariaDB data files, databases, and users are stored in /home/gwen/data/mariadb.

The setup scripts initialize the database the first time the container starts if the MariaDB data directory is empty.

## 8. Notes for debugging

If a service does not start correctly:

1. Check the container status with make status or docker compose ps.
2. Review logs with make logs or docker compose logs <service>.
3. Confirm that the host directories exist and have the expected permissions.
4. Confirm that the values in srcs/.env are valid and consistent.

The WordPress bootstrap script waits for MariaDB to become available before doing the installation, which helps avoid startup races.
