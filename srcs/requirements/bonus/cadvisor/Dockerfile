FROM alpine:3.24

RUN apk --update add --no-cache wget && \
    wget https://github.com/google/cadvisor/releases/download/v0.60.5/cadvisor-v0.60.5-linux-amd64 -O /usr/bin/cadvisor && \
    chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["/usr/bin/cadvisor", "-url_base_prefix=/cadvisor"]