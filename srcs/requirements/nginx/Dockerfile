FROM alpine:3.24

RUN apk update && apk add nginx

RUN mkdir -p /run/nginx

WORKDIR /etc/nginx

COPY /conf/nginx.conf .

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]