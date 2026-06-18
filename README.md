Ressources:  
[Guide Github Inception] https://github.com/vbachele/Inception/tree/main
[NGINX Beginner guide] https://nginx.org/en/docs/beginners_guide.html
[NGINX HTTPS Configuration] https://nginx.org/en/docs/http/configuring_https_servers.html
[WordPress Installation] https://www.dreamhost.com/blog/guide-to-wp-cli/#:~:text=The%20WP%2DCLI%20is%20a,faster%20using%20the%20WP%2DCLI.
[WordPress Script] https://developer.wordpress.org/cli/commands/
[MariaDB Installation] https://mariadb.com/docs/server/clients-and-utilities/deployment-tools/mariadb-install-db
[MariaDB Script] https://github.com/MariaDB/server/blob/main/scripts/mysql_secure_installation.sh

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