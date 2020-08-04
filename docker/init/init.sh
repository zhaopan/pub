#!/bin/bash

##
## mkdir some container configs
##
mkdir -p /mnt/nginx
mkdir -p /mnt/nginx/html
mkdir -p /mnt/mysql
mkdir -p /mnt/mysql/data
mkdir -p /mnt/gogs

##
## cp container configs
##

# nginx
docker cp nginx:/etc/nginx/nginx.conf /mnt/nginx/nginx.conf
docker cp nginx:/etc/nginx/conf.d /mnt/nginx

# mysql
docker cp mysql:/etc/mysql/my.cnf /mnt/mysql/my.cnf
docker cp mysql:/etc/mysql/conf.d /mnt/mysql

# drop container
docker rm -f mysql nginx gogs redis
