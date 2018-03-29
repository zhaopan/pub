# Docker Remark

## Install Docker

```bash
$curl -fsSL get.docker.com -o get-docker.sh
$sudo sh get-docker.sh --mirror Aliyun
$sudo systemctl enable docker
$sudo systemctl start docker
```

## Install nginx

```bash
$docker pull nginx
$docker run --name nginx -p 80:80 -d nginx
```

## Install apache

```bash
$docker pull httpd
```

## Install shadowsocks

```bash
$docker run -dt --name shadowsocks -p 22354:22354 -p 22353:22353/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 22354 -m chacha20-ietf -k 密码 --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:22354 -l :22353 -mode fast2 -dscp 46 -mtu 1350 -crypt salsa20 -datashard 7 -parityshard 3 -interval 10 -key kcp密码"
```

## Install docker-compose

```bash
$sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$sudo chmod +x /usr/local/bin/docker-compose
$docker-compose --version
```

## Create docker network

```bash
$docker network create mynet
```

## Centos Install mysql

## Pull mysql image from Docker Hub

```bash
$docker pull mysql
```

## Use `docker run` mysql for the first time

```bash
$sudo docker run --name=mysql -p 3306:3306 -e MYSQL\_ROOT\_PASSWORD=123456 -d mysql --net mynet
```

## run docker mysql

```bash
$docker exec -it mysql mysql -uroot -p
```

## Container Shell Access

```bash
$docker exec -it mysql bash
$create database if not exists gogs default character set utf8 COLLATE utf8_general_ci
```

## Centos Install gogs

## Create local directory for volume

```bash
$mkdir -p /var/gogs
```

## Pull gogs image from Docker Hub

```bash
$docker pull gogs/gogs
```

## Use `docker run` gogs for the first time

```bash
$sudo docker run --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data -d gogs/gogs --net mynet
```

## Use `docker start` gogs if you have stopped it

```bash
$docker start gogs
```

## docker yml.file

## dockerfile
