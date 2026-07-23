*This project has been created as part of the 42 curriculum by gwen*

# Inception Project

## Description

This project builds a complete web stack using Docker and Docker Compose. Its goal is to host a WordPress site behind Nginx with HTTPS, while also providing a database, cache, FTP access, and administration tools in a containerized environment.

The stack is composed of several services that work together:

- Nginx: serves the site over HTTPS and routes traffic to WordPress and the bonus services.
- WordPress: runs the web application and its PHP-FPM process.
- MariaDB: stores the WordPress database.
- Redis: improves performance by caching WordPress content.
- vsftpd: provides FTP access to the website files.
- Adminer: offers a lightweight database administration interface.
- cAdvisor: exposes container metrics and resource usage.

## Project description

This repository follows the 42 Inception project approach: each component is containerized and orchestrated through Docker Compose instead of being installed directly on the host. The project includes Dockerfiles and shell scripts under the srcs/requirements tree, as well as configuration files for Nginx, MariaDB, WordPress, FTP, Redis, Adminer, and cAdvisor.

### Why Docker is used here

Docker is used to isolate each service, simplify deployment, and make the environment reproducible. Each service runs in its own container with its own dependencies, which makes the stack easier to start, stop, rebuild, and debug.

### Design choices

- The services are defined in srcs/docker-compose.yaml.
- Environment variables are injected through srcs/.env for secrets and configuration values.
- Host data is persisted using bind mounts so the website files and database remain available across container restarts and rebuilds.
- The root Makefile provides simple commands to start and manage the whole stack.

### Comparison of key concepts

| Topic | Choice used here | Why |
| --- | --- | --- |
| Virtual Machines vs Docker | Docker | Docker is lighter, faster to start, and more suited for containerized micro-services. |
| Secrets vs Environment Variables | Environment variables | The project uses values such as database passwords and FTP credentials from srcs/.env for convenience during development and local deployment. |
| Docker Network vs Host Network | Docker network | Containers communicate through an internal bridge network, which is safer and cleaner than exposing everything directly on the host. |
| Docker Volumes vs Bind Mounts | Bind mounts | The project uses bind mounts to keep data on the host filesystem at fixed paths for persistence and easy inspection. |

## Instructions

### Prerequisites

Make sure the following are installed on the host:

- Docker Engine
- Docker Compose v2
- make
- sudo access for the project’s directory setup and cleanup steps

If you want to access the site locally using the configured domain, add the following entry to /etc/hosts:

- 127.0.0.1 gwen.42.fr

### Configuration

The main environment variables are stored in srcs/.env.

Important values include:

- MariaDB credentials: MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD
- WordPress credentials: WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL
- FTP credentials: FTP_USER, FTP_PASS

These values are consumed by the services at startup.

### Start the project

From the repository root, run:

- make

This creates the required host directories and starts all containers.

### Stop the project

- make down

### Check the project status

- make status

### View logs

- make logs

### Clean the environment

- make clean: remove containers and related resources
- make fclean: fully reset the stack and remove persisted data directories

## Structure of the repository

- srcs/docker-compose.yaml: container orchestration for the whole stack
- srcs/.env: runtime configuration and credentials
- srcs/requirements/nginx/: Nginx configuration and TLS setup
- srcs/requirements/wordpress/: WordPress installation and PHP-FPM setup
- srcs/requirements/mariadb/: MariaDB initialization and database setup
- srcs/requirements/bonus/redis/: Redis integration for WordPress
- srcs/requirements/bonus/ftp/: FTP service configuration
- srcs/requirements/bonus/adminer/: Adminer setup
- srcs/requirements/bonus/cadvisor/: Metrics dashboard setup

## Usage

Once the stack is running, these URLs are available:

- Main website: https://gwen.42.fr/
- WordPress admin panel: https://gwen.42.fr/wp-admin/
- Adminer: https://gwen.42.fr/adminer/
- cAdvisor: https://gwen.42.fr/cadvisor/
- Static page: https://gwen.42.fr/static/

## Service verification and debug commands

The following commands help confirm that the services are working correctly.

### 1. Check the containers

- docker compose -f srcs/docker-compose.yaml ps

### 2. Check the website and reverse proxy

- curl -k -I https://gwen.42.fr/
- curl -k -I https://gwen.42.fr/adminer/
- curl -k -I https://gwen.42.fr/cadvisor/

### 3. Check Redis

- docker exec -it redis redis-cli
- MONITOR

The Redis container should accept the connection and show commands being processed.

### 4. Check FTP

- lftp -u gwen,123 localhost
- ls
- debug 3
- put /etc/hostname -o test-ftp.php
- ls
- get test-ftp.php -o /tmp/test-recu.php

These commands verify that the FTP server can list the web root and upload/download files successfully.

### 5. Check WordPress and the database

- docker exec -it wordpress sh
- wp --info
- docker exec -it mariadb sh

## Resources

Classic references used while building this project:

- Docker Compose documentation: https://docs.docker.com/compose/
- Nginx documentation: https://nginx.org/en/docs/
- WordPress CLI documentation: https://developer.wordpress.org/cli/
- MariaDB documentation: https://mariadb.com/docs/
- Redis documentation: https://redis.io/docs/
- vsftpd documentation: https://linux.developpez.com/vsftpd/
- cAdvisor documentation: https://prometheus.io/docs/guides/cadvisor/

### Use of AI

AI was used only as a support tool when needed, mainly to help understand some technical concepts, review container configuration, debug specific issues during the setup of the stack and writting documentation (and reviewed by human). It was not used as a substitute for the actual implementation or validation of the project.