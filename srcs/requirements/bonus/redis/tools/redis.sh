#!/bin/sh

if [ ! -f "/etc/redis.conf.bak" ]; then
    # Create a backup copy of the original
    cp /etc/redis.conf /etc/redis.conf.bak

    sed -i "s|bind 127.0.0.1 -::1|bind * -::*|g" etc/redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf
else
    echo "/etc/redis/redis.conf.bak already exists"
fi

redis-server --protected-mode no