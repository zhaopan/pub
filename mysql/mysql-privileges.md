# mysql privileges

## 1.create database

```bash
mysql>use mysql;
mysql>create database if not exists channel default character set utf8 COLLATE utf8_general_ci;--创建数据库
```

## 2.create user

```bash
mysql>insert into mysql.user(Host,User,Password) values("%","mysqluser",password("mysqlpassword"));--mysqluser本地访问
mysql>insert into mysql.user(Host,User,Password) values("localhost","mysqluser",password("mysqlpassword"));--mysqluser用户远程访问
mysql>flush privileges;--刷新系统权限表
```

## 3.privileges

```bash
--本地用户
mysql>grant all privileges on channel.* to mysqluser@localhost;--所有权限
mysql>flush privileges;--刷新系统权限表
mysql>grant select,delete,update,create,drop on channel.* to mysqluser@localhost;--部分权限
mysql>flush privileges;--刷新系统权限表
--远程用户
mysql>grant all privileges on channel.* to mysqluser@"%";--所有权限
mysql>flush privileges;--刷新系统权限表
mysql>grant select,delete,update,create,drop on channel.* to mysqluser@"%";--部分权限
mysql>flush privileges;--刷新系统权限表
```

## create gogs database

```bash
create database gogs engine = innodb
create database if not exists gogs default character set utf8 COLLATE utf8_general_ci
```