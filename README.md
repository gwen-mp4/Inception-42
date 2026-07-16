Ressources:  
Guide Github Inception: https://github.com/vbachele/Inception/tree/main
NGINX Beginner guide: https://nginx.org/en/docs/beginners_guide.html
NGINX HTTPS Configuration: https://nginx.org/en/docs/http/configuring_https_servers.html
WordPress Installation: https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI.
WordPress Script: https://developer.wordpress.org/cli/commands/
MariaDB Installation: https://mariadb.com/docs/server/clients-and-utilities/deployment-tools/mariadb-install-db
MariaDB Script: https://github.com/MariaDB/server/blob/main/scripts/mysql_secure_installation.sh
Docker-compose: https://docs.docker.com/reference/compose-file/services/
Docker compose intall: https://docs.docker.com/compose/install/linux/#install-using-the-repository
Redis installation: https://dev.gaelbillon.com/installer-et-configurer-redis-pour-wordpress-en-5-minutes/
FTP-server (vsftpd): https://linux.developpez.com/vsftpd/

## Dockerfile
CMD to executing a command (command by default)
ENTRYPOINT to execute a .sh
**To find the path of the .conf, do this:**
-Create a rudimentary Dockerfile: FROM, RUN (install what you need) and CMD
-Write *CMD ["tail", "-f", "/dev/null"]*
-*docker build [-t <imageName>] .*
-*docker run -d --name <containerName> <imageName>*
-*docker exec -it <containerName> sh*
-_find /etc -name "*.conf"_
-CTRL+D to leave the container and *docker cp <containerName>:<path> <directory you want>
After that, you'll find the exact path where the .conf is located, now clean the image and the container
-*docker rm -f <containerName>* and if you want to remove image, do it
* Or just read the official Dockerfile
**If you can't execute the container**
-You can do this:
*docker run --rm --entrypoint sh __service-you-want__:latest -c "ls -R /etc/__service-you-want__"*  
*--rm* delete the container after execution  
*--entrypoint sh* replace the start command by the shell
*-c "ls -R /etc/__service-you-want__"* list recursively the directory's content
**If you want to see what's inside the original config file without running a container:**
*docker run --rm __service-you-want__:latest cat /etc/__service-you-want__/__file-you-want__*

# Docker commands:  
## To create a docker image:  
*docker build [-t <imageName>] .* (-t for name and don't forget the dot)
## To run a container:
*docker run -d --name <containerName> <imageName>*
## To enter a container:
*docker exec -it <containerName> sh*
## To stop a container:
*docker stop <containerName>*
## To remove a stopped container:
*docker rm <containerName>*
## To remove an image:
*docker image rm <imageName>*
**Prune**
## To remove all stopped containers:
*docker container prune*
## To remove all dangling images:
*docker image prune* (-a to include images that aren't used by existing containers)
## To remove networks that aren't used by containers:
*docker network prune*
## To remove everything (images, containers...):
*docker system prune* (-a for all kind of images)
## To see all images:
*docker image ls* (-a for stopped)
## To see all running container:
*docker ps* (-a including stopped)
## To execute all containers (.yaml)
*docker-compose up -d --build*

* To check redis cache
-docker exec -it redis redis-cli
-MONITOR
* To test if vsftpd works
-lftp -u gwen,123 localhost
-ls (to display /var/www/html)
-debug 3 (verbose)
-put /etc/hostname -o test-ftp.php (copy the hostname of the website to the file)
-ls
-get test-ftp.php -o /tmp/test-recu.php (download the file to /tmp)

LOG:
*10/06*
-Created Dockerfile for nginx
*15/06*
-Created Dockerfile and www.conf for WordPress
-TO-DO: wordpress.sh
*16/06*
-Wrote _wordpress.sh_, it works
-TO-DO: Dockerfile for mariadb
*18/06*:
-MariaDB dockerfile, config and .sh done, all work
TO-DO: Connect all containers (docker-compose.yaml)
*23/06*:
-.env file and docker-compose.yaml
TO-DO: Debug docker compose up
*24/06*:
Everything seems to work normally
To-do: Recheck everything (and do dev_doc.md and user_doc.md), do bonuses
*26/06*:
Fixed things
To-do: do bonuses
*01/07*:
-Added redis, fixed some issues, no problem for now
*03/07*:
-Added ftp server vsftpd, no issues for now
*16/07*
-Added static page, next, adminer