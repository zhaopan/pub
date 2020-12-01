# env-dockerfile.docker.compose

## Dockerfile

### 1、使用系统环境变量

eg:

`docker run -e VARIABLE=VALUE ...`

```text
web:
  image: "webapp:${TAG}"
```

### 2、通过environment设置，这种方法适用于正在运行的容器里，调用特定变量，可登陆容器输入env命令查看

eg:

`docker run -e VARIABLE ...`

```text
web:
  environment:
    - DEBUG=1
```

### 3、可以通过env\_file传入多个变量

eg:

`docker run --env-file=FILE ...`

```text
web:
  env_file:
    - web-variables.env
```

### 4、通过ARG命令传入

## docker-compose

### 1、像docker run -e一样，docker-compose也可使用`docker-compose run -e`

```bash
docker-compose run -e DEBUG=1 web python console.py
```

也可以传入shell里的值，而不用先赋值

```bash
docker-compose run -e DEBUG web python console.py
```

容器中DEBUG变量的值取自运行Compose的shell中相同变量的值

[docker-compose run用法](https://docs.docker.com/compose/reference/run/)

### 2、通过.env文件传入

可以设置docker-compose文件默认读取的变量配置文件.env

```text
$ cat .env
TAG=v1.5

$ cat docker-compose.yml
version: '3'
services:
  web:
    image: "webapp:${TAG}"
```

当运行`docker-compose up`命令时，web服务使用镜像webapp:v1.5，之前可以通过`docker-compose config`命令确认变量是否正确

```bash
###
### 变量配置文件读取顺序
###

# 1
Compose file

# 2
Shell environment variables

# 3
Environment file

# 4
Dockerfile

# 5
Variable is not defined
```

### 3、运行docker-compose build命令时，通过–build-arg variable传入参数

以下是简单例子，docker build 也可以通过此方法传入：

```bash
1 导入运行PHP用户的UID为系统环境变量，变量名为PHPID
2 在PHP的dockerfile里添加 ARG PHPID
3 sudo -E docker-compose build --build-arg PHPID php # 构建php服务
4 sudo -E docker-compose up -d #创建容器
```

注意：如果是root可以不加-E，如果是普通用户sudo要加上

仅当没有用于环境或env\_file的Docker Compose条目时，才能在Dockerfile中设置任何ARG或ENV设置

