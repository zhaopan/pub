# docker-compose

## 常用命令

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

## Docker-compose模板文件

Compose允许用户通过一个docker-compose.yml模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。Compose模板文件是一个定义服务、网络和卷的YAML文件。Compose模板文件默认路径是当前目录下的docker-compose.yml，可以使用.yml或.yaml作为文件扩展名。Docker-Compose标准模板文件应该包含version、services、networks 三大部分，最关键的是services和networks两个部分。

eg:

```yml
version: '3'
services:
  web:
    image: dockercloud/hello-world
    ports:
      - 8080
    networks:
      - front-tier
      - back-tier

  redis:
    image: redis
    links:
      - web
    networks:
      - back-tier

  lb:
    image: dockercloud/haproxy
    ports:
      - 80:80
    links:
      - web
    networks:
      - front-tier
      - back-tier
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

networks:
  front-tier:
    driver: bridge
  back-tier:
    driver: bridge
```
Compose目前有三个版本分别为Version 1，Version 2，Version 3，Compose区分Version 1和Version 2（Compose 1.6.0+，Docker Engine 1.10.0+）。Version 2支持更多的指令。Version 1将来会被弃用。

### image

image是指定服务的镜像名称或镜像ID。如果镜像在本地不存在，Compose将会尝试拉取镜像。

```yml
services:
    web:
        image: hello-world
```
### build

服务除了可以基于指定的镜像，还可以基于一份Dockerfile，在使用up启动时执行构建任务，构建标签是build，可以指定Dockerfile所在文件夹的路径。Compose将会利用Dockerfile自动构建镜像，然后使用镜像启动服务容器。

```yml
build: /path/to/build/dir
```

也可以是相对路径，只要上下文确定就可以读取到Dockerfile。

```yml
build: ./dir
```

设定上下文根目录，然后以该目录为准指定Dockerfile。

```yml
build:
  context: ../
  dockerfile: path/of/Dockerfile
```

build都是一个目录，如果要指定Dockerfile文件需要在build标签的子级标签中使用dockerfile标签指定。 如果同时指定image和build两个标签，那么Compose会构建镜像并且把镜像命名为image值指定的名字。

### context

context选项可以是Dockerfile的文件路径，也可以是到链接到git仓库的url，当提供的值是相对路径时，被解析为相对于撰写文件的路径，此目录也是发送到Docker守护进程的context

```yml
build:
  context: ./dir
```

### dockerfile

使用dockerfile文件来构建，必须指定构建路径

```yml
build:
  context: .
  dockerfile: Dockerfile-alternate
```

### commond

```yml
command: bundle exec thin -p 3000
```

### container_name

Compose的容器名称格式是：<项目名称><服务名称><序号>
可以自定义项目名称、服务名称，但如果想完全控制容器的命名，可以使用标签指定：

```yml
container_name: app
```

### depends_on

在使用Compose时，最大的好处就是少打启动命令，但一般项目容器启动的顺序是有要求的，如果直接从上到下启动容器，必然会因为容器依赖问题而启动失败。例如在没启动数据库容器的时候启动应用容器，应用容器会因为找不到数据库而退出。depends_on标签用于解决容器的依赖、启动先后的问题

```yml
version: '2'
services:
  web:
    build: .
    depends_on:
      - db
      - redis
  redis:
    image: redis
  db:
    image: postgres
```

上述YAML文件定义的容器会先启动redis和db两个服务，最后才启动web 服务。

### PID

```yml
pid: "host"
```

将PID模式设置为主机PID模式，跟主机系统共享进程命名空间。容器使用pid标签将能够访问和操纵其他容器和宿主机的名称空间。

### ports

ports用于映射端口的标签。使用HOST:CONTAINER格式或者只是指定容器的端口，宿主机会随机映射端口。

```yml
ports:
 - "3000"
 - "8000:8000"
 - "49100:22"
 - "127.0.0.1:8001:8001"
```

当使用HOST:CONTAINER格式来映射端口时，如果使用的容器端口小于60可能会得到错误得结果，因为YAML将会解析xx:yy这种数字格式为60进制。所以建议采用字符串格式。

### extra_hosts

添加主机名的标签，会在/etc/hosts文件中添加一些记录。

```yml
extra_hosts:
 - "somehost:162.242.195.82"
 - "otherhost:50.31.209.229"
```

启动后查看容器内部hosts：

```yml
162.242.195.82  somehost
50.31.209.229   otherhost
```

### volumes

挂载一个目录或者一个已存在的数据卷容器，可以直接使用 [HOST:CONTAINER]格式，或者使用[HOST:CONTAINER:ro]格式，后者对于容器来说，数据卷是只读的，可以有效保护宿主机的文件系统。 Compose的数据卷指定路径可以是相对路径，使用 . 或者 .. 来指定相对目录。 数据卷的格式可以是下面多种形式

```yml
volumes:
  # 只是指定一个路径，Docker 会自动在创建一个数据卷（这个路径是容器内部的）。
  - /var/lib/mysql

  # 使用绝对路径挂载数据卷
  - /opt/data:/var/lib/mysql

  # 以 Compose 配置文件为中心的相对路径作为数据卷挂载到容器。
  - ./cache:/tmp/cache

  # 使用用户的相对路径（~/ 表示的目录是 /home/<用户目录>/ 或者 /root/）。
  - ~/configs:/etc/configs/:ro

  # 已经存在的命名的数据卷。
  - datavolume:/var/lib/mysql
```

如果不使用宿主机的路径，可以指定一个volume_driver。

### volumes_from

从另一个服务或容器挂载其数据卷：

```yml
volumes_from:
   - service_name
     - container_name
```

### dns

自定义DNS服务器。可以是一个值，也可以是一个列表。

```yml
dns：8.8.8.8
dns：
    - 8.8.8.8
      - 9.9.9.9
```

### expose

暴露端口，但不映射到宿主机，只允许能被连接的服务访问。仅可以指定内部端口为参数，如下所示：

```yml
expose:
    - "3000"
    - "8000"
```

### links

链接到其它服务中的容器。使用服务名称（同时作为别名），或者服务名称:服务别名（如 SERVICE:ALIAS），例如

```yml
links:
    - db
    - db:database
    - redis
```

### net

设置网络模式。

```yml
net: "bridge"
net: "none"
net: "host"
```
## Docker-compose模板文件示例

### Docker-compose模板文件编写

docker-compose.yml

```yml
version: '2'
services:
  web1:
    image: nginx
    ports:
      - "6061:80"
    container_name: "web1"
    networks:
      - dev
  web2:
    image: nginx
    ports:
      - "6062:80"
    container_name: "web2"
    networks:
      - dev
      - pro
  web3:
    image: nginx
    ports:
      - "6063:80"
    container_name: "web3"
    networks:
      - pro
networks:
  dev:
    driver: bridge
  pro:
    driver: bridge
```
docker-compose.yml文件指定了3个web服务

### 启动应用

创建一个webapp目录，将docker-compose.yaml文件拷贝到webapp目录下，使用docker-compose启动应用。

```bash
docker-compose up -d
```

### 服务访问

通过浏览器访问web1，web2，web3

```bash
http://127.0.0.1:6061
http://127.0.0.1:6062
http://127.0.0.1:6063
```