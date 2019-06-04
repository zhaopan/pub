#!/bin/bash

##
## mkdir some container configs
##
mkdir -p ~/nginx
mkdir -p ~/nginx/html
mkdir -p ~/mysql
mkdir -p ~/mysql/data
mkdir -p ~/gogs

##
## cp tmp-container configs
##

# nginx
docker cp tmpnginx:/etc/nginx/nginx.conf ~/nginx/nginx.conf
docker cp tmpnginx:/etc/nginx/conf.d ~/nginx

# mysql
docker cp tmpmysql:/etc/mysql/my.cnf ~/mysql/my.cnf
docker cp tmpmysql:/etc/mysql/conf.d ~/mysql

# drop tmp-container
docker rm -f tmpmysql tmpnginx

# drop docker tmp-network
docker network rm root_tmpnetwork
