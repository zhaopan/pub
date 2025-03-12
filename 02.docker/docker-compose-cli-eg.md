# docker-compose-cli-eg

- [docker-compose-cli-eg](#docker-compose-cli-eg)
  - [ip/network](#ipnetwork)
  - [docker-compose.yml + Dockerfile + env](#docker-composeyml--dockerfile--env)
  - [build | start | restart | stop | down | rebuild](#build--start--restart--stop--down--rebuild)
  - [cli-list](#cli-list)
  - [reference](#reference)

.env

```bash
### IPV4_ADDRESS ##############################
SUBNET=172.19.0.0/16

# nginx
NGINX_IP=172.19.0.2

# mysql
MYSQL_IP=172.19.0.3

# redis
REDIS_IP=172.19.0.4
```

create network

```bash
# 创建网络
docker network create --subnet=172.19.0.0/16 devops_proxy
```

## ip/network

docker-compose.yml

创建网络

```yml
version: "3.8"
services:
  nginx:
    image: nginx
    networks:
      backend:
        ipv4_address: ${NGINX_IP}

networks:
  # 创建一个新网络，名为：<docker-compose-filePath>_backend
  backend:
    driver: bridge
    ipam:
      config:
        - subnet: ${SUBNET}
```

加入已经存在的网络

```yml
version: "3.8"
services:
  nginx:
    image: nginx
    networks:
      backend:
        ipv4_address: ${NGINX_IP}

networks:
  # 已经存在的网络 <backend>
  backend:
    external: true

# OR

version: "3.8"
services:
  nginx:
    image: nginx
    networks:
      backend:
        ipv4_address: ${NGINX_IP}
networks:
  backend:
    # 已经存在的网络 <devops_proxy>
    name: devops_proxy
    external: true

# OR

version: "3.8"
services:
  nginx:
    image: nginx
    networks:
      ipv4_address: ${NGINX_IP}
networks:
  # 默认网络
  default:
    external:
      # 已经存在的网络 <devops_proxy>
      name: devops_proxy
```

## docker-compose.yml + Dockerfile + env

.env

```yml
MAINTAINER=zhaopan <zhaopan@github.com>
REDIS_VERSION=5.0
REDIS_DATA_PATH=./data/redis5
REDIS_CONF_PATH=./redis/redis5.conf
REDIS_PORT=6379
```

Dockerfile

```bash
ARG VERSION
ARG MAINTAINER

FROM redis:${VERSION}

ARG MAINTAINER

LABEL maintainer=${MAINTAINER}

# 复制时区配置
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD ["redis-server"]

EXPOSE 6379
```

docker-compose.yml

```yml
version: "3.8"
services:
  redis:
    build:
      context: .
      args:
        - VERSION=${REDIS_VERSION}
        - MAINTAINER=${MAINTAINER}
    container_name: redis
    command: redis-server /etc/redis/redis.conf
    restart: always
    ports:
      - ${REDIS_PORT}:6379
    volumes:
      - ${REDIS_DATA_PATH}:/data
      - ${REDIS_CONF_PATH}:/etc/redis/redis.conf
    networks:
      backend:
        ipv4_address: ${REDIS_IP}

networks:
  backend:
    name: devops_proxy
    external: true
```

## build | start | restart | stop | down | rebuild

```bash
# 编译
docker-compose build <services-names>

##
## start | restart | down | rebuild
##

# 首次执行耗时较久，耐心等待
docker-compose up -d <services-names>

# 修改配置文件后重启即可
docker-compose restart <services-names>

# 修改 dockerfile 或者 env 文件之后 rebuild 可生效
docker-compose up -d --build <services-names>

# 停止
docker-compose stop

# 停止并删除容器
docker-compose down

# 停止并删除容器+镜像
docker-compose down --rmi all
```

## cli-list

```bash
# docker-compose
docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]
-f --file           # FILE指定Compose模板文件，默认为docker-compose.yml
-p --project-name   # NAME 指定项目名称，默认使用当前所在目录为项目名
--verbose           # 输出更多调试信息
-v,-version         # 打印版本并退出
--log-level LEVEL   # 定义日志等级(DEBUG, INFO, WARNING, ERROR, CRITICAL)

# docker-compose up
docker-compose up [options] [--scale SERVICE=NUM...] [SERVICE...]
-d                # 在后台运行服务容器
-no-color         # 不是有颜色来区分不同的服务的控制输出
-no-deps          # 不启动服务所链接的容器
--force-recreate  # 强制重新创建容器，不能与-no-recreate同时使用
–no-recreate      # 如果容器已经存在，则不重新创建，不能与–force-recreate同时使用
–no-build         # 不自动构建缺失的服务镜像
–build            # 在启动容器前构建服务镜像
–abort-on-container-exit  # 停止所有容器，如果任何一个容器被停止，不能与-d同时使用
-t, –timeout TIMEOUT      # 停止容器时候的超时（默认为10秒）
–remove-orphans           # 删除服务中没有在compose文件中定义的容器

# 列出项目中所有在运行的容器
docker-compose ps [options] [SERVICE...]

# 停止正在运行的容器，可以通过docker-compose start 再次启动
docker-compose stop [options] [SERVICE...]
-t, –timeout TIMEOUT  # 停止容器时候的超时（默认为10秒）

# 查看帮助
docker-compose -h

# 停止和删除容器、网络、卷、镜像
docker-compose down [options]
–rmi type         # 删除镜像，类型必须是：all，删除compose文件中定义的所有镜像；local，删除镜像名为空的镜像
-v, –volumes      # 删除已经在compose文件中定义的和匿名的附在容器上的数据卷
–remove-orphans   # 删除服务中没有在compose中定义的容器

docker-compose down # 停用移除所有容器以及网络相关

# 查看服务容器的输出。默认情况下，docker-compose将对不同的服务输出使用不同的颜色来区分。可以通过–no-color来关闭颜色。
docker-compose logs [options] [SERVICE...]
-f 跟踪日志输出
docker-compose logs # 查看服务容器的输出

# 构建（重新构建）项目中的服务容器。
### 服务容器一旦构建后，将会带上一个标记名。可以随时在项目目录下运行docker-compose build来重新构建服务
docker-compose build [options] [--build-arg key=val...] [SERVICE...]
–compress   # 通过gzip压缩构建上下环境
–force-rm   # 删除构建过程中的临时容器
–no-cache   # 构建镜像过程中不使用缓存
–pull       # 始终尝试通过拉取操作来获取更新版本的镜像
-m, –memory # MEM为构建的容器设置内存大小
–build-arg  # key=val为服务设置build-time变量

# 拉取服务依赖的镜像
docker-compose pull [options] [SERVICE...]
–ignore-pull-failures # 忽略拉取镜像过程中的错误
–parallel             # 多个镜像同时拉取
–quiet                # 拉取镜像过程中不打印进度信息

# 重启项目中的服务
docker-compose restart [options] [SERVICE...]
-t, –timeout TIMEOUT,   # 指定重启前停止容器的超时（默认为10秒）

# 删除所有（停止状态的）服务容器
### 删除所有（停止状态的）服务容器。推荐先执行docker-compose stop命令来停止容器。
docker-compose rm [options] [SERVICE...]
–f, –force,  # 强制直接删除，包括非停止状态的容器
-v,          # 删除容器所挂载的数据卷

# 启动已经存在的服务容器。
docker-compose start [SERVICE...]

# 设置指定服务运行的容器个数
docker-compose scale
docker-compose scale web=3 db=2 # 通过service=num的参数来设置数量

# 暂停一个服务容器
docker-compose pause [SERVICE...]

# 通过发送SIGKILL信号来强制停止服务容器
docker-compose kill [options] [SERVICE...]

# 支持通过-s参数来指定发送的信号，例如通过如下指令发送SIGINT信号：
docker-compose kill -s SIGINT

# 验证并查看compose文件配置
docker-compose config [options]
–resolve-image-digests  # 将镜像标签标记为摘要
-q, –quiet    # 只验证配置，不输出。 当配置正确时，不输出任何内容，当文件配置错误，输出错误信息
–services     # 打印服务名，一行一个
–volumes      # 打印数据卷名，一行一个

# 为服务创建容器
docker-compose create [options] [SERVICE...]
–force-recreate   # 重新创建容器，即使配置和镜像没有改变，不兼容–no-recreate参数
–no-recreate      # 如果容器已经存在，不需要重新创建，不兼容–force-recreate参数
–no-build         # 不创建镜像，即使缺失
–build            # 创建容器前，生成镜像

# 执行
docker-compose exec [options] SERVICE COMMAND [ARGS...]
-d            # 分离模式，后台运行命令。
–privileged   # 获取特权。
–user USER    # 指定运行的用户。
-T            # 禁用分配TTY，默认docker-compose exec分配TTY。
–index=index  # 当一个服务拥有多个容器时，可通过该参数登陆到该服务下的任何服务，
              # 例如：docker-compose exec –index=1 web /bin/bash ，web服务中包含多个容器

# 显示某个容器端口所映射的公共端口
docker-compose port [options] SERVICE PRIVATE_PORT
–protocol=proto # 指定端口协议，TCP（默认值）或者UDP
–index=index    # 如果同意服务存在多个容器，指定命令对象容器的序号（默认为1）

# 推送服务依的镜像
docker-compose push [options] [SERVICE...]
–ignore-push-failures #忽略推送镜像过程中的错误

# 停止运行的容器
docker-compose stop [options] [SERVICE...]

# 恢复处于暂停状态中的服务
docker-compose unpause [SERVICE...]
```

## reference

[docker-compose](https://docs.docker.com/compose/reference/)

[compose-cli](https://docs.docker.com/engine/reference/commandline/compose/)
