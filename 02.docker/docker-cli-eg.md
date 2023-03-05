# docker-cli-eg

- [docker-cli-eg](#docker-cli-eg)
  - [search](#search)
  - [build](#build)
  - [run | restart | stop | update | rm | rmi](#run--restart--stop--update--rm--rmi)
  - [rm](#rm)
  - [rmi](#rmi)
  - [network](#network)
  - [exec](#exec)
  - [pipe](#pipe)
  - [reference](#reference)

## search

```bash
# search
docker search redis
```

## build

```bash
## build
docker build [OPTIONS] PATH | URL | -

# eg:

docker build  .
docker build -t redis .
docker build -t zhaopan/redis:latest .
docker build -t zhaopan/redis:latest redis5.0 .

# build from NginxDockerfile
docker build -f NginxDockerfile -t nginx:latest .
```

## run | restart | stop | update | rm | rmi

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
docker restart [OPTIONS] CONTAINER [CONTAINER...]
docker stop [OPTIONS] CONTAINER [CONTAINER...]
docker update [OPTIONS] CONTAINER [CONTAINER...]
docker rm [OPTIONS] CONTAINER [CONTAINER...]
docker rmi [OPTIONS] IMAGE [IMAGE...]

# eg:

# run
docker run --name nginx -it nginx

# restart
docker restart nginx -t 10 # 10秒后重启

# stop
docker stop nginx -t 10 # 10秒后停止

# update
docker update --kernel-memory 80M nginx # 修改内核内存
docker update --restart=always nginx  # 修改启动方式
```

## rm

```bash
docker rm [OPTIONS] CONTAINER [CONTAINER...]
--force , -f    # 强制删除正在运行的容器
--link , -l     # 删除指定链接
--volumes , -v  # 删除与容器关联的匿名卷

# eg:

# 删除容器
docker rm redis

# 强制删除容器
docker rm --f redis

# 删除默认桥接网络上指定的链接
docker rm --l /webapp/redis

# 删除卷
docker rm --v redis

# 删除容器并删除挂载卷
docker create -v awesome:/foo -v /bar --name bzz redis
docker rm -v bzz
```

## rmi

```bash
docker rmi [OPTIONS] IMAGE [IMAGE...]
--force,-f  # 强制删除
--no-prune  # 不删除为标记的 parents

# eg:

docker rmi nginx
docker rmi nginx -f
docker rmi nginx --no-prune
```

## network

若你有多个容器之间需要互相连接，推荐使用 [docker-compose](docker-compose-cli-eg.md)

create | connect | disconnect | inspect | ls | prune | rm

```bash
connect     # Connect a container to a network
create      # Create a network
disconnect  # Disconnect a container from a network
inspect     # Display detailed information on one or more networks
ls          # List networks
prune       # Remove all unused networks
rm          # Remove one or more networks

# create
docker network create [OPTIONS] NETWORK
# eg:
docker network create --subnet=172.18.0.0/16 devops_proxy
docker run -itd --name mysql --net devops_proxy --ip 172.18.0.2 centos:latest /bin/bash

# connect
docker network connect [OPTIONS] NETWORK CONTAINER
# eg:
# 将容器加入到指定网络中
docker network connect devops_proxy redis
# 将容器加入到指定网络中，并设置IP
docker network connect --ip 172.18.0.2 devops_proxy redis
# 如果指定，容器的 IP 地址将在停止的容器重新启动时重新应用。如果 IP 地址不再可用，容器将无法启动。保证 IP 地址可用的一种方法是--ip-range在创建网络时指定一个地址，并从该范围之外选择静态 IP 地址。这可确保当此容器不在网络上时，不会将 IP 地址提供给另一个容器。
docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 multi-host-network
```

## exec

```bash
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

# eg:

# nginx: 刷新配置
docker exec -it nginx nginx -s reload

# mysql: ...
docker exec -it mysql bash
docker exec -it mysql mysql -uroot -p
create database if not exists <my-db> default character set utf8 COLLATE utf8_general_ci
```

## pipe

```bash
# 停止所有容器
docker stop $(docker ps -q)

# 删除所有停止容器
docker rm $(docker ps -aq)

# 删除所有运行容器
docker stop $(docker ps -q) & docker rm $(docker ps -aq)

# 删除所有容器
docker rm $(docker ps --filter status=exited -q)

# 删除所有容器
docker ps --filter status=exited -q | xargs docker rm
```

## reference

[docker-builder](https://docs.docker.com/engine/reference/builder/)

[docker-cli](https://docs.docker.com/engine/reference/commandline/cli/)
