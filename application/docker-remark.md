# Docker Remark

**Install Docker**

- **aliyun docker mirror**

```bash
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh --mirror Aliyun
```

**Auto start docker**

```bash
$ sudo systemctl enable docker
$ sudo systemctl start docker
```

**Install docker-compose**
```bash
$ sudo curl -L https://github.com/docker/compose/releases/download/1.20.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version
```

**Install nginx**

- **Default config nginx**

```bash
$ docker pull nginx
$ docker run --name nginx -p 80:80 -d nginx
```

- **Custom config nginx**

```bash
# 创建配置文件目录
$ mkdir -p ~/nginx/conf

# 将默认的配置文件复制到配置文件目录,然后删掉该容器
$ docker run --name tmp-nginx-container -d nginx
$ docker cp tmp-nginx-container:/etc/nginx/nginx.conf ~/nginx/conf/nginx.conf
$ docker rm -f tmp-nginx-container

# 运行自定义配置文件的nginx容器
$ docker run \
--name nginx \
-p 80:80 -d \
-v ~/nginx/html:/usr/share/nginx/html \
-v ~/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
-v ~/nginx/conf/conf.d:/etc/nginx/conf.d \
nginx
```



**Install apache**
```bash
$ docker pull httpd
```

**Install shadowsocks**
```bash
$ docker run -dt --name shadowsocks -p 22354:22354 -p 22353:22353/udp mritd/shadowsocks -m "ss-server" -s "-s 0.0.0.0 -p 22354 -m chacha20-ietf -k 密码 --fast-open" -x -e "kcpserver" -k "-t 127.0.0.1:22354 -l :22353 -mode fast2 -dscp 46 -mtu 1350 -crypt salsa20 -datashard 7 -parityshard 3 -interval 10 -key kcp密码"
```

**Install mysql**

```bash
# Pull mysql image from Docker Hub
$ docker pull mysql

# Use `docker run` mysql for the first time
$ sudo docker run --name=mysql -p 3306:3306 -e MYSQL\_ROOT\_PASSWORD=123456 -d mysql --net mynet

# run docker mysql
$ docker exec -it mysql mysql -uroot -p

# Container Shell Access
$ docker exec -it mysql bash
$ create database if not exists gogs default character set utf8 COLLATE utf8_general_ci
```

**Install gogs**

```bash
# Create local directory for volume
$ mkdir -p /var/gogs

# Pull gogs image from Docker Hub
$ docker pull gogs/gogs

# Use `docker run` gogs for the first time
$ sudo docker run --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data -d gogs/gogs --net mynet

# Use `docker start` gogs if you have stopped it
$ docker start gogs
```

**Create docker network**
```bash
$ docker network create mynet
```

**docker yml.file**

**Dockerfile**

**Lookup docker logs**
```bash
journalctl -u docker.service
docker logs -f -t nginx
```