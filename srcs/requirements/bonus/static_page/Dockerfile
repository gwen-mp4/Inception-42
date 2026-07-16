FROM alpine:3.24

RUN apk update

RUN mkdir -p /var/www/html/static_page
COPY ./tools/ /var/www/html/static_page/

CMD ["sh", "-c", "while true; do sleep 3600; done"]