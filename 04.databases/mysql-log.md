# mysql-log

## 基础查询

```bash
show master status; #查看mysql状态
show binlog events in 'mysql-bin.000008' \G
show binlog events in 'mysql-bin.000008' from 1919\G
show variables like '%log%'; #find variables in mysql\G
```

## MYSQL binlog日志定期清除：

### 方法1.修改配置文件

```bash
expire_logs_days = 10 #mysql-bin.000001等二进制日志10天后自动过期清除
```

### 方法2.手动删除

```bash
rm -f mysql-bin.00001
```

### 方法3.SQL删除

```bash
purge master logs to 'mysql-bin.000009'; #删除不包括mysql-bin.000009的之前所有二进制日志
purge master logs before '2010-01-26 00:00:00'; #清除2010-01-26之前的所有日志
```

## 查看二进制日志及日志事件

```bash
show binlog events\G;
show master logs;
show binary logs;
```

## 不完全解决办法

```bash
slave stop;
set global sql_slave_skip_counter=1;
slave start;
show slave status\G;
```

二进制文件一般用来做replication同步，当查看slave上同步正确，或者是同步已经完成了，这时如果硬盘空间又不是很大的话，那我们可以手动去清理这些binary文件。 很简单：

```bash
reset master;
```

### MYSQL启用日志和查看日志

mysql有以下几种日志： 错误日志：-log-err 查询日志：-log 慢查询日志：-log-slow-queries 更新日志：-log-update 二进制日志：-log-bin

show variables like 'log\_%'; \#是否启用了日志 show master status; \#当前的日志状态 show master logs; \#展示二进制日志数目

看二进制日志文件

```bash
shell>mysqlbinlog mail-bin.000001
或者
shell>mysqlbinlog mail-bin.000001 | tail
```

在配置文件中指定log的输出位置. Windows：Windows 的配置文件为 my.ini，一般在 MySQL 的安装目录下或者 c:\Windows 下。 Linux：Linux 的配置文件为 my.cnf ，一般在 /etc 下。

在linux下： Sql代码

## 在\[mysqld\] 中输入

```text
# log
log-error=/usr/local/mysql/log/error.log
log=/usr/local/mysql/log/mysql.log
long_query_time=2
log-slow-queries= /usr/local/mysql/log/slowquery.log
```

开启慢查询 long\_query\_time =2 --是指执行超过多久的sql会被log下来，这里是2秒 log-slow-queries= /usr/local/mysql/log/slowquery.log --将查询返回较慢的语句进行记录 log-queries-not-using-indexes = nouseindex.log --log下没有使用索引的query log=mylog.log --对所有执行语句进行记录
