# MYSQL Remark

## MYSQL backups

```bash
mysqldump -u root -p DATABASE>ALL.sql
```

## MYSQL recovery

```bash
mysql -u root -p DATABASE<ALL.sql
```

## Remote connection MYSQL

```bash
mysql -h 127.0.0.0 -u root -p
```

## cleanup

清理二进制日志(Binary Log)

```bash
# 查看当前二进制日志文件
SHOW BINARY LOGS;

# 删除所有二进制日志，并重新开始新的日志文件
RESET MASTER;

# 或删除指定日期前的日志
PURGE BINARY LOGS BEFORE '2025-05-20 00:00:00';

# 设置自动过期时间(单位天)
[mysqld]
expire_logs_days=7
```

## 常见错误

```bash
# 常见错误
https://help.aliyun.com/zh/ecs/common-linux-instance-of-mysql-service-could-not-start-or-start-exception-handling
```
