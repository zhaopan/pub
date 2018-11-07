# Docker Remark

## Install Docker

- aliyun docker mirror

```bash
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
```

- Auto start docker

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

- Install docker-compose

```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

## Install nginx

- Default config nginx

```bash
docker pull nginx
docker run --name tmp-nginx -p 80:80 -d nginx
docker start tmp-nginx
docker rm -f tmp-nginx
```

- Custom config nginx

```bash
# 创建配置文件目录
mkdir -p ~/nginx/conf

# 将默认的配置文件复制到配置文件目录,然后删掉该容器
docker run --name tmp-nginx-container -d nginx
docker cp tmp-nginx-container:/etc/nginx/nginx.conf ~/nginx/conf/nginx.conf
docker start tmp-nginx-container
docker rm -f tmp-nginx-container

# 运行自定义配置文件的nginx容器
sudo docker run \
--name nginx \
--restart=always \
-p 80:80 \
-v ~/nginx/html:/usr/share/nginx/html \
-v ~/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
-v ~/nginx/conf/conf.d:/etc/nginx/conf.d \
-d nginx

# 自动重启
docker update --restart=always nginx
```

- ~/nginx/conf/nginx.conf

```nginx
user  nginx;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    keepalive_timeout  65;
    include /etc/nginx/conf.d/*.conf;
}

```

- ~/nginx/conf/conf.d/default.conf

```nginx
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        autoindex  on;
    }
}

```

- ~/nginx/conf/conf.d/git.conf

```nginx
server {
    listen       80;
    server_name  git.***.com;
    client_max_body_size 50m;
    location / {
        #一定要注意这里是docker容器的内网地址+端口,以"/"结尾,不然会报错。
        proxy_pass http://172.17.0.3:3000/;
        proxy_redirect default;
        proxy_buffer_size 64k;
        proxy_buffers 32 32k;
        proxy_busy_buffers_size 128k;
    }
}
```

## Install apache

```bash
docker pull httpd
```

## Install shadowsocks

```bash
docker run -dt --name shadowsocks -p 22354:22354 -p 22353:22353/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 22354 -m chacha20-ietf -k 密码 --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:22354 -l :22353 -mode fast2 -dscp 46 -mtu 1350 -crypt salsa20 -datashard 7 -parityshard 3 -interval 10 -key kcp密码"
```

## Install mysql

```bash
# Pull mysql image from Docker Hub
docker pull mysql

# Use `docker run` mysql for the first time
sudo docker run --name=mysql -p 3306:3306 -e MYSQL\_ROOT\_PASSWORD=123456 -d mysql

# run docker mysql
docker exec -it mysql mysql -uroot -p

# Container Shell Access
docker exec -it mysql bash
create database if not exists gogs default character set utf8 COLLATE utf8_general_ci

# 自动重启
docker update --restart=always mysql
```

## Install gogs

```bash
# Create local directory for volume
mkdir -p /var/gogs

# Pull gogs image from Docker Hub
docker pull gogs/gogs

# Use `docker run` gogs for the first time
sudo docker run \
--name=gogs \
--restart=always \
-p 10022:22 \
-p 10080:3000 \
-v /var/gogs:/data \
-d gogs/gogs

# Use `docker start` gogs if you have stopped it
docker start gogs

# 自动重启
docker update --restart=always gogs

# 进入gogs容器修改配置
docker exec -it gogs bash

# nginx proxy gogs conf
see cref="install nginx"
```

## Create docker network

```bash
docker network create mynet
# 步骤1: 创建自定义网络
# 创建自定义网络，并且指定网段：172.17.0.0/16
docker network create --subnet=172.17.0.0/16 mynetwork
# 步骤2: 创建Docker容器
docker run -itd --name mysql --net mynetwork --ip 172.17.0.2 centos:latest /bin/bash
```

## docker yml.file

## Dockerfile

## Lookup docker logs

```bash
journalctl -u docker.service
docker logs -f -t nginx
```

## No done remark

- docker cleanup

```bash
docker image prune
docker container prune
docker volume prune
docker network prune
docker system prune
docker system prune --volumes
```