Ressources:  
[Guide Github Inception] https://github.com/vbachele/Inception/tree/main
[NGINX Beginner guide] https://nginx.org/en/docs/beginners_guide.html
[NGINX HTTPS Configuration] https://nginx.org/en/docs/http/configuring_https_servers.html

Docker commands:  
## To create a docker image:  
docker build [-t <imageName>] . (-t for name and don't forget the dot)
## To run a container:
docker run -d --name <containerName> <imageName>
## To enter a container:
docker exec -it <containerName> sh
## To stop a container:
docker stop <containerName>
## To remove a stopped container:
docker rm <containerName>
**Prune**
## To remove all stopped containers:
docker container prune
## To remove all dangling images:
docker image prune (-a to include images that aren't used by existing containers)
## To remove networks that aren't used by containers:
docker network prune
## To remove everything (images, containers...):
docker system prune (-a for all kind of images)
## To see all running container:
docker ps (-a including stopped)

LOG:
*10/06*
-Created Dockerfile for nginx
