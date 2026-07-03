FROM alpine:3.24

RUN apk --update add --no-cache vsftpd

COPY ./conf/vsftpd.conf /tmp/vsftpd.conf

COPY ./tools/ftp_server.sh /tmp/ftp_server.sh

EXPOSE 21 21100-21110

ENTRYPOINT [ "sh", "/tmp/ftp_server.sh" ]