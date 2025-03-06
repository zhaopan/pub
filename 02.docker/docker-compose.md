# docker-compose

compose允许用户通过一个docker-compose.yml模板文件（yaml 格式）来定义一组相关联的应用容器为一个项目（project）。compose模板文件是一个定义服务、网络和卷的yaml文件。compose模板文件默认路径是当前目录下的docker-compose.yml，可以使用.yml或.yaml作为文件扩展名。docker-compose标准模板文件应该包含version、services、networks 三大部分，最关键的是services和networks两个部分。

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

compose目前有三个版本分别为version 1，version 2，version 3，compose区分version 1和version 2（compose 1.6.0+，docker engine 1.10.0+）。version 2支持更多的指令。version 1将来会被弃用。

## image

image是指定服务的镜像名称或镜像id。如果镜像在本地不存在，compose将会尝试拉取镜像。

```yml
services:
    web:
        image: hello-world
```

## build

服务除了可以基于指定的镜像，还可以基于一份Dockerfile，在使用up启动时执行构建任务，构建标签是build，可以指定Dockerfile所在文件夹的路径。compose将会利用Dockerfile自动构建镜像，然后使用镜像启动服务容器。

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

build都是一个目录，如果要指定Dockerfile文件需要在build标签的子级标签中使用Dockerfile标签指定。 如果同时指定image和build两个标签，那么Compose会构建镜像并且把镜像命名为image值指定的名字。

## context

context选项可以是Dockerfile的文件路径，也可以是到链接到git仓库的url，当提供的值是相对路径时，被解析为相对于撰写文件的路径，此目录也是发送到Docker守护进程的context

```yml
build:
  context: ./dir
```

## Dockerfile

使用Dockerfile文件来构建，必须指定构建路径

```yml
build:
  context: .
  dockerfile: Dockerfile-alternate
```

## commond

```yml
command: bundle exec thin -p 3000
```

## container_name

Compose的容器名称格式是：<项目名称><服务名称><序号>
可以自定义项目名称、服务名称，但如果想完全控制容器的命名，可以使用标签指定：

```yml
container_name: app
```

## depends_on

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

## PID

```yml
pid: "host"
```

将PID模式设置为主机PID模式，跟主机系统共享进程命名空间。容器使用pid标签将能够访问和操纵其他容器和宿主机的名称空间。

## ports

ports用于映射端口的标签。使用HOST:CONTAINER格式或者只是指定容器的端口，宿主机会随机映射端口。

```yml
ports:
 - "3000"
 - "8000:8000"
 - "49100:22"
 - "127.0.0.1:8001:8001"
```

当使用HOST:CONTAINER格式来映射端口时，如果使用的容器端口小于60可能会得到错误得结果，因为YAML将会解析xx:yy这种数字格式为60进制。所以建议采用字符串格式。

## extra_hosts

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

## volumes

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

## volumes_from

从另一个服务或容器挂载其数据卷：

```yml
volumes_from:
   - service_name
     - container_name
```

## dns

自定义DNS服务器。可以是一个值，也可以是一个列表。

```yml
dns：8.8.8.8
dns：
    - 8.8.8.8
      - 9.9.9.9
```

## expose

暴露端口，但不映射到宿主机，只允许能被连接的服务访问。仅可以指定内部端口为参数，如下所示：

```yml
expose:
    - "3000"
    - "8000"
```

## links

链接到其它服务中的容器。使用服务名称（同时作为别名），或者服务名称:服务别名（如 SERVICE:ALIAS），例如

```yml
links:
    - db
    - db:database
    - redis
```

## net

设置网络模式。

```yml
net: "bridge"
net: "none"
net: "host"
```
