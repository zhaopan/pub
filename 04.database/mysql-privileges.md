# mysql privileges

_**MYSQL Version:8.0+**_

## 1.create database

```sql
use mysql;

--创建数据库
create database if not exists work default character set utf8mb4 collate utf8mb4_unicode_ci;
```

## 2.create user

```sql
--dbroot本地访问
insert into mysql.user(host,user,password) values('localhost','dbroot',password('mysqlpassword'));

--dbroot远程访问
insert into mysql.user(host,user,password) values('%','dbroot',password('mysqlpassword'));

############
--OR--
############

--dbroot本地访问
create user 'dbroot'@'localhost' identified by 'mysqlpassword';

--dbroot远程访问
create user 'dbroot'@'%' identified by 'mysqlpassword';

--刷新系统权限表
flush privileges;
```

## 3.privileges

```sql
---
--本地用户
--

--所有权限
grant all privileges on work.* to 'dbroot'@localhost;
flush privileges;

--部分权限
grant select,delete,update,insert,create,drop on work.* to 'dbroot'@localhost;
flush privileges;

--
--远程用户
--
--所有权限
grant all privileges on work.* to 'dbroot'@'%';
flush privileges;

--部分权限
grant select,delete,update,insert,create,drop on work.* to 'dbroot'@'%';
flush privileges;
```

## grant

```sql
--给dbroot所有权限
grant all privileges on *.* to 'dbroot'@'%';
flush privileges;

-- 授权 dbroot 用户的所有权限并设置远程访问,grant all on 表示所有权限，% 表示通配所有 host，可以访问远程。
grant all on *.* to 'dbroot'@'%';
flush privileges;

-- 撤销mysql 权限
revoke all on *.* from 'dbroot'@'%';
flush privileges;

-- 修改加密规则和密码
alter user 'dbroot'@'%' identified by '123456' password expire never;

--OR--
alter user 'dbroot'@'%' identified with mysql_native_password by '123456';
flush privileges;
```

## demo: create dev database

```sql
--create database
create database if not exists work default character set utf8mb4 collate utf8mb4_unicode_ci;

--create db user
create user 'dbroot'@'%' identified by '123456';

--privileges
grant alter,select,delete,update,insert,create,drop on work.* to 'dbroot'@'%';

--privileges(all)
grant all on *.* to 'dbroot'@'%';

--alter db user's password
alter user 'dbroot'@'%' identified with mysql_native_password by '123456';

--flush privileges
flush privileges;
```
