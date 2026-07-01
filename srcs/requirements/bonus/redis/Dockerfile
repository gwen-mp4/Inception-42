FROM alpine:3.24

RUN apk --update add --no-cache redis

COPY ./tools/redis.sh /tmp/redis.sh

EXPOSE 6379

ENTRYPOINT [ "sh", "/tmp/redis.sh" ]