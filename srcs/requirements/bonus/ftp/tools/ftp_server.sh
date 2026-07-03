#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

    mkdir -p /var/www/html

    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
else
    echo "/etc/vsftpd/vsftpd.conf.bak already exists"
fi

# Create FTP user if necessary
if ! id "$FTP_USER" >/dev/null 2>&1; then
    adduser -D "$FTP_USER" --disabled-password
    echo "$FTP_USER:$FTP_PASS" | chpasswd
else
    echo "FTP user already exists"
fi

# Giving permissions
chown -R "$FTP_USER":"$FTP_USER" /var/www/html

# Adding FTP user to vsftpd user list
echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf