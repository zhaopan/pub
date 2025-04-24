# mysql | MySQL 配置与管理实战手册

本文件是 `MySQL` 的详细配置、性能优化与操作实战文档，涵盖：

- ✅ 配置文件结构与关键参数说明
- ✅ 用户权限管理与远程连接开放
- ✅ 主从复制、误删恢复操作
- ✅ 索引与查询优化建议

---

## 📁 配置路径与启动命令

- 主配置文件：
  - Debian/Ubuntu：`/etc/mysql/my.cnf`
  - CentOS/RHEL：`/etc/my.cnf`
- 数据目录：`/var/lib/mysql`
- 启动命令：`systemctl restart mysql`

---

## 🧩 常用配置参数说明

```ini
[mysqld]
bind-address = 0.0.0.0         # 允许远程连接
max_connections = 300
default-storage-engine = InnoDB
sql_mode = STRICT_TRANS_TABLES
character-set-server = utf8mb4
collation-server = utf8mb4_general_ci
```

> 🧠 注释：
>
> - `sql_mode` 建议开启严格模式避免隐式转换
> - `utf8mb4` 避免 emoji/多语言乱码问题

---

## 👤 用户管理与远程连接配置

```sql
CREATE USER 'admin'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

- 修改 `bind-address` 并确保 3306 端口已开放（配合 UFW / 安全组）
- 验证连接：

```bash
mysql -h your.server.ip -u admin -p
```

---

## 🔁 主从复制配置（简化版）

### 主库配置 `my.cnf`

```ini
server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
```

```sql
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'replpass';
SHOW MASTER STATUS;
```

### 从库配置

```ini
server-id = 2
relay_log = /var/log/mysql/mysql-relay-bin
```

```sql
CHANGE MASTER TO
  MASTER_HOST='主库IP',
  MASTER_USER='repl',
  MASTER_PASSWORD='replpass',
  MASTER_LOG_FILE='mysql-bin.000001',
  MASTER_LOG_POS=123;
START SLAVE;
```

---

## 🧪 实战场景：误删数据库后恢复

背景：

- 生产数据库被误执行 `DROP DATABASE`

处理：

- 立即停机备份 binlog（或使用 `mysqlbinlog` 回放）
- 用 `mysqlbinlog` 指定时间点恢复：

```bash
mysqlbinlog --start-datetime="..." --stop-datetime="..." /log/mysql-bin.00000X > restore.sql
mysql -u root -p < restore.sql
```

---

## 🧠 性能优化建议

- 查询慢日志定位：

```ini
slow_query_log = 1
long_query_time = 1
log_output = FILE
```

- 使用 `EXPLAIN` 分析执行计划
- 创建索引避免全表扫描
- 合理分页：避免 `LIMIT offset` 过大

---

## 🛠️ 常见故障与排查建议

| 问题          | 原因                           | 解决方式                            |
| ------------- | ------------------------------ | ----------------------------------- |
| 远程连接失败  | bind-address 限制 / 防火墙未开 | 检查配置并放行 3306                 |
| 登录报错 1045 | 用户密码错 / 主机限制          | 检查 user@host 授权                 |
| 主从不同步    | binlog 文件错位                | 检查 `show slave status\G` 错误提示 |

---

## 🧠 历史踩坑记录

- 曾因只授权 `admin@localhost` 导致远程登录失败
- `server-id` 重复导致主从无效
- 开启慢查询日志后未设置 log_output 导致日志为空
- MySQL8 需使用 `caching_sha2_password` 兼容性考虑客户端支持

> 📁 建议本文件归档于 `/software/full-config/mysql-deep.md`，适用于长期维护或生产环境部署文档。
