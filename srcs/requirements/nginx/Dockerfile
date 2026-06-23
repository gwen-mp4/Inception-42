FROM alpine:3.24

RUN apk update && apk upgrade && apk add --no-cache \
    sudo \
    nginx \
    openssl

RUN mkdir -p /run/nginx

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 365 -nodes\
    -keyout /etc/nginx/ssl/gwen.key \
    -out /etc/nginx/ssl/gwen.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42 School/OU=gwen/CN=gwen"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]