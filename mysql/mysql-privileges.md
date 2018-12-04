# mysql privileges

## 1.create database

```sql
use mysql;
create database if not exists channel default character set utf8 COLLATE utf8_general_ci;--创建数据库
```

## 2.create user

```sql
insert into mysql.user(Host,User,Password) values("%","mysqluser",password("mysqlpassword"));--mysqluser本地访问

insert into mysql.user(Host,User,Password) values("localhost","mysqluser",password("mysqlpassword"));--mysqluser用户远程访问
flush privileges;--刷新系统权限表
```

## 3.privileges

```sql
--本地用户
grant all privileges on channel.* to mysqluser@localhost;--所有权限
flush privileges;--刷新系统权限表

grant select,delete,update,create,drop on channel.* to mysqluser@localhost;--部分权限
flush privileges;--刷新系统权限表

--远程用户
grant all privileges on channel.* to root@"%";--所有权限
flush privileges;--刷新系统权限表

grant select,delete,update,create,drop on channel.* to mysqluser@"%";--部分权限
flush privileges;--刷新系统权限表
```

## create gogs database

```sql
create database gogs engine = innodb
create database if not exists gogs default character set utf8 COLLATE utf8_general_ci
```

## MYSQL8 授权

```sql
--给root所有权限
grant all privileges on *.* to root@"%";
flush privileges;--刷新系统权限表

-- 授权 root 用户的所有权限并设置远程访问,GRANT ALL ON 表示所有权限，% 表示通配所有 host，可以访问远程。
GRANT ALL ON *.* TO 'root'@'%';
flush privileges;--刷新系统权限表

-- 修改加密规则
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456' PASSWORD EXPIRE NEVER;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
flush privileges;--刷新系统权限表
```