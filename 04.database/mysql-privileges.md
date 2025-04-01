# mysql privileges

`MYSQL 8.0+`

## 1.create database

```sql
use mysql;

-- 创建数据库
create database if not exists work default character set utf8mb4 collate utf8mb4_unicode_ci;
```

## 2.create user

```sql
-- 本地用户
insert into mysql.user(host,user,password) values('localhost','dbroot',password('<mysql-pwd>'));

-- 远程用户
insert into mysql.user(host,user,password) values('%','dbroot',password('<mysql-pwd>'));

-- OR --

-- 本地用户
create user 'dbroot'@'localhost' identified by '<mysql-pwd>';

-- 远程用户
create user 'dbroot'@'%' identified by '<mysql-pwd>';

flush privileges;
```

## 3.privileges

```sql
-- 本地用户(所有权限)
grant all privileges on work.* to 'dbroot'@localhost;

-- 远程用户(所有权限)
grant all privileges on work.* to 'dbroot'@'%';

-- OR --

-- 本地用户(部分权限)
grant select,delete,update,insert,create,drop on work.* to 'dbroot'@localhost;

-- 远程用户(部分权限)
grant select,delete,update,insert,create,drop on work.* to 'dbroot'@'%';
```

## grant

```sql
-- 给dbroot所有权限
grant all privileges on *.* to 'dbroot'@'%';

-- 授权 dbroot 用户的所有权限并设置远程访问,grant all on 表示所有权限，% 表示通配所有 host，可以访问远程。
grant all on *.* to 'dbroot'@'%';

-- 撤销mysql 权限
revoke all on *.* from 'dbroot'@'%';

-- 修改加密规则和密码
alter user 'dbroot'@'%' identified by '<mysql-pwd>' password expire never;
-- OR --
alter user 'dbroot'@'%' identified with mysql_native_password by '<mysql-pwd>';
```

## eg

```sql
-- use mysql;

-- 创建数据库
create database if not exists work default character set utf8mb4 collate utf8mb4_unicode_ci;

-- 创建远程访问用户
create user 'dbroot'@'%' identified by '<mysql-pwd>';

-- 授权(all)
grant all on *.* to 'dbroot'@'%';

-- OR --

-- 授权
grant alter,select,delete,update,insert,create,drop on work.* to 'dbroot'@'%';

-- 修改密码
alter user 'dbroot'@'%' identified with mysql_native_password by '<mysql-pwd>';

-- 刷新
flush privileges;
```
