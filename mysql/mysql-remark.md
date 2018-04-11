# MYSQL Remark

MYSQL backups
```bash
mysqldump -u root -p DATABASE>ALL.sql
```

MYSQL recovery

```bash
mysql -u root -p DATABASE<ALL.sql
```

Remote connection MYSQL
```bash
mysql -h 127.0.0.0 -u root -p
```

因为硬盘满了，Starting MySQL.Manager of pid-file quit without updating file.[FAILED]
因为硬盘满了，mysql启动不起来了。
登录上去看了一下，发现原因。
删除mysql的日志文件，重启mysql发现错误：Starting MySQL.Manager of pid-file quit without updating file.[FAILED]
网上有不少这个原因的解释，但是都不是我想说的。我要说的原因其实很白痴：data/mysql-bin.index没有删除，data/mysql-bin.index是存放日志文件索引的文件，只删除了日志文件而没有对日志的索引文件做处理显然是不行的。
删除data/mysql-bin.index文件，再service mysqld start就可以了。