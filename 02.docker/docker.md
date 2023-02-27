# docker

- [docker](#docker)
  - [install docker](#install-docker)
  - [install docker-compose](#install-docker-compose)
  - [compose file format compatibility matrix](#compose-file-format-compatibility-matrix)
  - [create docker network](#create-docker-network)
- [docker network list](#docker-network-list)
  - [nginx](#nginx)
  - [mysql](#mysql)
  - [gogs](#gogs)
  - [php-fpm](#php-fpm)
  - [postgres](#postgres)
  - [shadowsocks](#shadowsocks)
  - [redis](#redis)
  - [pure-ftp](#pure-ftp)
  - [rabbitmq](#rabbitmq)
  - [docker logs](#docker-logs)
  - [docker cleanup](#docker-cleanup)
  - [docker configs](#docker-configs)
  - [remark](#remark)
  - [dotnet core 内存设置](#dotnet-core-内存设置)

![docker](https://cdn.fkwar.com/77C5FC6E-21CF-46F7-96B2-A18F254D295A.png)

![docker](https://cdn.fkwar.com/C72B0911-6881-438B-9925-570A00FE020B.png)

## install docker

```bash
# aliyun docker mirror
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

#
# or
#
curl -sSL https://get.daocloud.io/docker | sh

# install docker systemctl
sudo systemctl enable docker
sudo systemctl start docker

### eg: centos9 Install docker

# Uninstall old versions
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Set up the repository
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### end centos9 Install docker

# qcloud centos7/8
yum update
yum install epel-release -y
yum clean all
yum install docker-io -y

# Test install
docker  -v
```


## install docker-compose

```bash
# 1.下载 docker-compose
# 推荐使用daocloud安装
sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

#
#or
#

sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# 2.安装 docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 3.test install
docker-compose -v
```

## compose file format compatibility matrix

* [Compatibility matrix](https://docs.docker.com/compose/compose-file/compose-versioning/)

* [Github matrix](https://github.com/docker/compose)

| Compose file format | Docker Engine |
| :------------------ | :------------ |
| 1                   | 1.9.0+        |
| 2.0                 | 1.10.0+       |
| 2.1                 | 1.12.0+       |
| 2.2, 3.0, 3.1, 3.2  | 1.13.0+       |
| 2.3, 3.3, 3.4, 3.5  | 17.06.0+      |
| 2.4                 | 17.12.0+      |
| 3.6                 | 18.02.0+      |
| 3.7                 | 18.06.0+      |
| 3.8                 | 19.03.0+      |

## create docker network

```bash
# create custom docker network
docker network create --subnet=172.18.0.0/16 mynetwork

# demo
docker run -itd --name mysql --net mynetwork --ip 172.18.0.2 centos:latest /bin/bash
```

## docker network list

```bash
# nginx
nginx 172.18.0.2

# mysql
mysql 172.18.0.3

# gogs
gogs 172.18.0.4

# php-fpm
php-fpm 172.18.0.5

# postgres
postgres 172.18.0.6
```

## nginx

```bash
# Pull nginx image from Docker Hub
docker pull nginx

# Create local directory for volume
mkdir -p ~/nginx/conf
mkdir -p ~/nginx/conf/conf.d
mkdir -p ~/nginx/html

# run the default configuration of nginx to copy the configuration file
docker run --name tmp-nginx -p 80:80 -d nginx
docker cp tmp-nginx:/etc/nginx/conf.d ~/nginx/conf
docker cp tmp-nginx:/etc/nginx/nginx.conf ~/nginx/conf/nginx.conf
docker start tmp-nginx
docker rm -f tmp-nginx

## reload nginx configs
docker exec -it nginx nginx -s reload

# run nginx container
docker run \
--name nginx \
--restart=always \
--net mynetwork \
--ip 172.18.0.2 \
-p 80:80 \
-v ~/nginx/html:/usr/share/nginx/html \
-v ~/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
-v ~/nginx/conf/conf.d:/etc/nginx/conf.d \
-d nginx
```

* ~/nginx/conf/nginx.conf

```yml
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

* ~/nginx/conf/conf.d/default.conf

```yml
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

* ~/nginx/conf/conf.d/git.conf

```yml
server {
    listen       80;
    server_name  git.***.com;
    client_max_body_size 50m;
    location / {
        # 一定要注意这里是docker容器的内网地址+端口,以"/"结尾,不然会报错。
        proxy_pass http://gogs:3000/;
        proxy_redirect default;
        proxy_buffer_size 64k;
        proxy_buffers 32 32k;
        proxy_busy_buffers_size 128k;
    }
}
```

## mysql

```bash
# Pull mysql image from Docker Hub
docker pull mysql

# create mysql's configuration folder
mkdir -p ~/mysql
mkdir -p ~/mysql/data

# run mysql container
docker run \
--name=mysql \
--restart=always \
--net mynetwork \
--ip 172.18.0.3 \
-p 3306:3306 \
-v ~/mysql/my.cnf:/etc/mysql/my.cnf:ro \
-v ~/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql

# run mysql in container
docker exec -it mysql mysql -uroot -p

# container shell access
docker exec -it mysql bash
create database if not exists gogs default character set utf8 COLLATE utf8_general_ci
```

## gogs

```bash
# Pull gogs image from Docker Hub
docker pull gogs/gogs

# Create local directory for volume
mkdir -p ~/gogs

# Use `docker run` gogs for the first time
docker run \
--name=gogs \
--restart=always \
--net mynetwork \
--ip 172.18.0.4 \
-p 10022:22 \
-p 10080:3000 \
-v ~/gogs:/data \
-d gogs/gogs

# Use `docker start` gogs if you have stopped it
docker start gogs

# update gogs's configs
vim ~/gogs/conf/app.ini

# nginx proxy gogs conf
see cref="nginx"
```

## php-fpm

```bash
# Pull php-fpm image from Docker Hub
docker pull bitnami/php-fpm

# run php-frm container
docker run \
--name php-fpm \
--restart=always \
--net mynetwork \
--ip 172.18.0.5 \
-v ~/nginx/html:/usr/share/nginx/html \
-d docker.io/bitnami/php-fpm
# -d : 该参数为后台运行之意
# -v : 指定宿主机与容器的映射关系。/var/www/html为宿主机的项目目录（自定义的）,/usr/share/nginx/html为nginx服务器项目默认的路径。
```

## postgres

```bash
# Pull postgres image from Docker Hub
docker pull postgres

# run postgres container
docker run \
--name postgres \
--restart=always \
--net mynetwork \
--ip 172.18.0.6 \
-p 54321:5432 \
-e POSTGRES_PASSWORD=password123 \
-d postgres
```

## shadowsocks

```bash
docker run -dt --name shadowsocks --restart=always -p 22354:22354 -p 22353:22353/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 22354 -m chacha20-ietf-poly1305 -k <YOUR_SSR_PWD> --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:22354 -l :22353 -mode fast2 -dscp 46 -mtu 1350 -crypt salsa20 -datashard 7 -parityshard 3 -interval 10 -key <YOUR_SSR_PWD>"
```

## redis

```bash
docker search redis
docker pull redis:3.2
docker images
docker run --name redis --restart=always -p 6379:6379 -d redis:3.2 redis-server
docker ps
docker exec -ti redis redis-cli
```

## pure-ftp

```bash
# https://github.com/stilliard/docker-pure-ftpd

# 1.用docker下载pure-ftp
docker pull stilliard/pure-ftpd:hardened

# 2.下载完后直接运行
docker run -dt --name ftpd_server -p 21:21 -p 30000-30009:30000-30009 -e "PUBLICHOST=localhost" --privileged=true --restart=always -v ~/nginx/html/des:/home/ftpusers/www stilliard/pure-ftpd:hardened bash
#使用绑定IP为192.168.1.66，如果是公开FTP的话，可以不写IP。这里只是本机测试
#不使用官方教程的端口号30000-30009，因为30000-30009端口只能满足5个用户同时FTP登陆。计算方式为“(最大端口号-最小端口号) / 2”。所以我这里修改为可以满足100个用户同时连接登陆
#做了个目录映射，把本机的/home/ftpusers/des目录映射到pure-ftp的/home/ftpusers/www下

# 3.登陆pure-ftp容器
docker exec -it ftpd_server /bin/bash

# 4.在容器内新建用户（用户名为：www）
pure-pw useradd www -u ftpuser -d /home/ftpusers/www
#运行这个命令后会让输入两次密码，即FTP用户（www）的登陆密码 ftpdef

# 5.保存
pure-pw mkdb
#这个命令不可少，不然刚刚新建的用户就不生效了

# 6.运行FTP
/usr/sbin/pure-ftpd -c 100 -C 100 -l puredb:/etc/pure-ftpd/pureftpd.pdb -E -j -R -P $PUBLICHOST -p 30000:30009 &
# -c 100为：允许同时连接的客户端数列100
# -C 100为：同一IP最大的连接数100
# 这两个数值与端口号30000:30009对应上

# 7.防火墙设置
firewall-cmd --permanent --zone=public --add-port=30000-30009/tcp
firewall-cmd --reload
```

## rabbitmq

```bash
# mangement的版本,包含web管理页面
docker pull rabbitmq:management

# eg:
docker run -d
--name myrabbitmq
-p 5672:5672
-p 15672:15672
-v /d/docker/data:/var/lib/rabbitmq
-e RABBITMQ_DEFAULT_VHOST=my_vhost
-e RABBITMQ_DEFAULT_USER=admin
-e RABBITMQ_DEFAULT_PASS=admin
rabbitmq:management

# -d 后台运行
# –name 指定RabbitMQ容器名称
# -p 映射端口
# -v 数据卷映射位置
# RABBITMQ_DEFAULT_USER 指定用户账号
# RABBITMQ_DEFAULT_PASS 指定账号密码
# RABBITMQ_DEFAULT_VHOST 指定虚拟主机名称

# eg:
docker run -d -p 5672:5672 -p 15672:15672 \
-e RABBITMQ_DEFAULT_USER=admin \
-e RABBITMQ_DEFAULT_PASS=rbmq \
-v ${your host rabbitmq-content}/data:/var/lib/rabbitmq  \
-v ${your host rabbitmq-content}/conf/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf \
-v ${your host rabbitmq-content}/logs/:/var/log/rabbitmq/log/ \
--name ${your Instance name} ${rabbitmq-image}:${tag}

docker cp ${your container-name}:/etc/rabbitmq/rabbitmq.conf ${your host rabbitmq-content}/conf/
docker cp ${your container-name}:/var/log/rabbitmq/log/ ${your host rabbitmq-content}/logs/
```

## docker logs

```bash
journalctl -u docker.service
docker logs -f -t nginx
```

## docker cleanup

```bash
docker image prune -f
docker container prune -f
docker volume prune -f
docker network prune -f
docker system prune -f
docker system prune --volumes -f
```

## docker configs

```bash
# windows
%programdata%\docker\config\daemon.json

# linux
/etc/docker/daemon.json
```

## remark

```bash
# docker-compose.yml
docker-compose up -d

# docker-compose services build
docker-compose up -d nginx

# Dockerfile
docker build -t nginx .

# selected dockerfile build
docker build -f xxxDockerfile.txt -t xxx:v1 .

# restart
docker update --restart=always gogs

# 1.停止所有容器
docker stop $(docker ps -q)

# 2.删除所有停止容器
docker rm $(docker ps -aq)

# 3.删除所有运行容器
docker stop $(docker ps -q) & docker rm $(docker ps -aq)
```

## dotnet core 内存设置

```xml
<PropertyGroup>
    <ServerGarbageCollection>false</ServerGarbageCollection>
    <!---ServerGarbageCollection ： 服务器垃圾收集-->
    <ConcurrentGarbageCollection>true</ConcurrentGarbageCollection>
    <!---ServerGarbageCollection ： 并发垃圾收集-->
</PropertyGroup>
```
