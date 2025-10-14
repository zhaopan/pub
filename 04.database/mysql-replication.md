# MySQL 主从复制配置方案

- 服务器 A (主) -> 服务器 B (从)

- 此方案旨在配置服务器 B 作为服务器 A 的实时备份/准同步副本，实现数据的同步和高可用性。

## 预备工作与信息记录

- 1: 网络和端口：确保服务器 A 的防火墙开放了 3306 端口，允许服务器 B 访问
- 2: IP 地址：记录两台服务器的 IP 地址
  - A_SERVER_IP: 服务器 A 的实际 IP 地址
  - B_SERVER_IP: 服务器 B 的实际 IP 地址

---

## 步骤一：配置服务器 A (主/Master)

### 修改 MySQL 配置文件

- 编辑 A 服务器上的 MySQL 配置文件（如 /etc/my.cnf 或 /etc/mysql/mysql.conf.d/mysqld.cnf）。在 [mysqld] 部分添加或修改以下配置：

```yml
[mysqld]
# 1. 设定唯一 ID (必须是唯一的正整数，例如 1)
server-id = 1

# 2. 开启二进制日志（Binlog），这是复制的基础
log-bin = mysql-bin

# 3. 设定 Binlog 格式 (推荐 ROW，数据更安全)
binlog_format = ROW

# 4. 确保 MySQL 监听外部连接 (如果配置文件中存在 bind-address，请确保它不是 127.0.0.1)
# bind-address = 0.0.0.0
```

- 操作：保存文件后，重启 MySQL 服务使配置生效。

```bash
sudo systemctl restart mysql

# 或 sudo service mysql restart
```

### 创建复制专用用户

- 登录 A 服务器的 MySQL 命令行，创建复制用户并赋予其 REPLICATION SLAVE 权限。

注意：请替换 'replica_user'、'your_password' 和 'B_SERVER_IP' 为您的实际值。

```bash
-- 登录 MySQL
mysql -u root -p

-- 创建用户并授权
CREATE USER 'replica_user'@'B_SERVER_IP' IDENTIFIED BY 'your_password';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'B_SERVER_IP';

-- 刷新权限
FLUSH PRIVILEGES;
```

### 获取主服务器状态（起点）

- 执行命令，记录下 Binlog 文件名 和 位置

```bash
SHOW MASTER STATUS;

| File             | Position |
| :--------------- | :------- |
| mysql-bin.000001 | 388      |

记录：
- MASTER_LOG_FILE: mysql-bin.000001 (您实际获取到的值)
- MASTER_LOG_POS: 388 (您实际获取到的值)
```

---

## 步骤二：配置服务器 B (从/Replica)

### 修改MySQL配置文件

- 编辑 B 服务器的 MySQL 配置文件，在 [mysqld] 部分添加或修改以下内容：

```yml
[mysqld]
# 1. 设定唯一 ID (必须不同于 A 的 ID，例如 2)
server-id = 2
```

- 操作：保存文件后，重启 MySQL 服务

```bash
sudo systemctl restart mysql
# 或 sudo service mysql restart
```

### 配置复制连接并启动

- 登录 B 服务器的 MySQL 命令行，使用 步骤一 记录的信息进行配置。

注意：替换所有占位符为您记录的实际值。

```bash
-- 登录 MySQL
mysql -u root -p

-- 确保停止任何可能的旧复制进程
STOP SLAVE;

-- 配置主服务器信息，使用步骤一记录的值
CHANGE MASTER TO
    MASTER_HOST='A_SERVER_IP',              # A 服务器的 IP 地址
    MASTER_USER='replica_user',             # 复制专用用户名
    MASTER_PASSWORD='your_password',        # 复制专用密码
    MASTER_LOG_FILE='mysql-bin.000001',     # 步骤一记录的 File 值
    MASTER_LOG_POS=388;                     # 步骤一记录的 Position 值

-- 启动复制进程
START SLAVE;
```

---

## 步骤三：验证复制状态

- 在 B 服务器 的 MySQL 命令行执行以下命令，检查复制是否成功启动。

```bash
SHOW SLAVE STATUS\G

- 必须检查的关键指标：
- 1. Slave_IO_Running：必须是 Yes
- 2. Slave_SQL_Running：必须是 Yes
- 3. Seconds_Behind_Master：理想情况是 0（表示实时同步）。

- 验证测试
- 在 A 服务器上执行一次数据写入操作，然后立即在 B 服务器上查询，确认数据已同步。
```

---

## 常见问题处理

### 1. Slave_IO_Running 为 No

- 问题原因：B 无法连接到 A，或 A 上的认证失败。
- 排查步骤：
  - 防火墙：检查 A 服务器的防火墙是否开放了 3306 端口。
  - 网络：使用 ping 或 telnet B_SERVER_IP 3306 确认网络连通性。
  - 用户：检查 CHANGE MASTER TO 中的 MASTER_USER, MASTER_PASSWORD, MASTER_HOST 是否正确。
  - 日志：查看 B 服务器的 MySQL 错误日志（通常是 /var/log/mysql/error.log），查找具体的连接错误。

### 2. Slave_SQL_Running 为 No

- 问题原因：B 在执行从 A 接收到的 SQL 语句时遇到了错误，导致复制线程停止。常见于数据不一致或主从配置不当。
- 排查步骤：
  - 错误日志：查看 B 服务器的 MySQL 错误日志（error.log），找到导致停止的 Last_SQL_Error 详情。
  - 数据不一致：如果错误是主键冲突 (Duplicate entry) 或找不到记录 (No such row)，说明在复制开始之前 A 和 B 的数据可能就不一致。
  - 解决方案：记录 Last_SQL_Error 提示的 Binlog 文件和位置，使用 SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1; 跳过该错误事务，然后 START SLAVE; 重新尝试复制。
  - 强制模式：若经常出现错误，可以在 B 的配置文件中设置 slave_skip_errors=all，但这不推荐，因为它会忽略数据不一致问题。

### 3. Seconds_Behind_Master 很大（有延迟）

- 问题原因：B 无法及时处理 A 的写入操作，通常是 B 服务器负载高或网络带宽不足。
- 排查步骤：
- B 负载：检查 B 服务器的 CPU、内存和磁盘 I/O 是否成为瓶颈。
- 长事务：检查 A 服务器是否有长时间运行的大型事务（如批量插入/更新）。
- 优化：如果 B 主要用于读，考虑在 B 上优化查询或索引。
- 提升硬件：如果负载持续过高，可能需要升级 B 服务器的硬件。

### 4. server-id 配置错误

- 问题原因：A 和 B 的 server-id 相同，或者其中一台没有配置 server-id。
- 排查步骤：
  - 检查：确保 A 和 B 配置文件中的 server-id 是唯一的正整数。
  - 修复：修改 server-id 后，必须重启 MySQL 服务。
