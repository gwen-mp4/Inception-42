FROM alpine:3.24

RUN apk --update add --no-cache wget \
    php85 \
    php85-mysqli

COPY ./tools/script.sh /

ENTRYPOINT ["/script.sh"]