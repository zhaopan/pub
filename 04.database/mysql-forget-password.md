# Mysql forget password

## 1.Begin

* 首先确认服务器出于安全的状态，也就是没有人能够任意地连接MySQL数据库。
* 因为在重新设置MySQL的root密码的期间，MySQL数据库完全出于没有密码保护的状态下，其他的用户也可以任意地登录和修改MySQL的信息。
* 可以采用将MySQL对外的端口封闭，并且停止Apache以及所有的用户进程的方法实现服务器的准安全状态。
* 最安全的状态是到服务器的Console上面操作，并且拔掉网线。

## 2.Change mySQL settings

```yml
vim /etc/my.cnf

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
# add line 'skip-grant-tables'
skip-grant-tables
```

## 3.Restart mysqld

```bash
# Restart mysqld
/etc/init.d/mysqld restart
```

## 4.Update mysql password

```sql
USE mysql;
UPDATE user SET authentication_string = password ('<your password>') WHERE User = 'root';
flush privileges;
quit;
```

## 5.Change mySQL settings back

```yml
vim /etc/my.cnf

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
# delete line 'skip-grant-tables'
# skip-grant-tables
```

## 6.Restart mysqld

```bash
# Restart mysqld
/etc/init.d/mysqld restart
```

