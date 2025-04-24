# redis | Redis 配置与实战手册（安全 & 性能）

本文件是 `Redis` 的详细配置与操作文档，涵盖：

- ✅ 配置文件关键项说明
- ✅ 权限控制与远程访问
- ✅ 持久化机制与清理策略
- ✅ 安全建议与误操作恢复

---

## 📁 路径与服务命令

- 主配置文件：`/etc/redis/redis.conf`
- 数据存储目录：`/var/lib/redis`
- 启动服务命令：`systemctl restart redis`

---

## 🧩 常用配置片段解释

```conf
bind 0.0.0.0
protected-mode yes
requirepass your_redis_password

appendonly yes                    # 开启 AOF 持久化
appendfsync everysec              # 每秒刷盘（折中）
save 900 1                        # 快照持久化策略（900秒内至少1次写）
```

> 🧠 注释：
>
> - `protected-mode` 在绑定 0.0.0.0 时必须开启或设置密码
> - `appendonly` 开启后可减少数据丢失风险，建议结合 `RDB` 使用

---

## 🔐 安全配置建议

- 避免开放公网 Redis 实例（默认无加密协议）
- 使用以下命令**禁用高危指令**：

```conf
rename-command FLUSHALL ""
rename-command CONFIG ""
rename-command SHUTDOWN ""
```

- 设置只读账号（仅从逻辑上隔离，Redis 无权限系统）

---

## 🧪 实战案例：Redis 持久化恢复

背景：

- Redis 宕机后重启数据丢失
- 未开启持久化

修复建议：

- 开启 `appendonly yes`，设置 `appendfsync everysec`
- 定期备份 `/var/lib/redis/appendonly.aof` 与 `dump.rdb`
- 异常重启后优先从 AOF 读取恢复数据

---

## 📈 性能与清理策略

- 查看当前内存：

```bash
redis-cli -a yourpassword info memory
```

- 清理策略：

```conf
maxmemory 512mb
maxmemory-policy allkeys-lru
```

- 使用 `MONITOR` 追踪实时请求流（开发调试时用）

---

## 🛠️ 常见故障与排查建议

| 问题             | 原因               | 解决方法                             |
| ---------------- | ------------------ | ------------------------------------ |
| `(error) NOAUTH` | 未登录验证         | 使用 `AUTH` 登录或配置 `requirepass` |
| Redis 无法连接   | 防火墙 / bind 限制 | 检查 bind + 端口（默认6379）         |
| AOF 文件过大     | 长时间未重写       | 执行 `bgrewriteaof` 生成新文件       |

---

## 🧠 历史经验与踩坑记录

- `CONFIG SET` 被误用导致线上实例参数被改（建议禁用）
- 忘记配置密码被扫描器入侵清空数据
- AOF 开启后未监控磁盘空间导致写满挂死
- 多实例部署忘记区分端口导致端口冲突

> 📁 建议归档于 `/software/full-config/redis-deep.md`，用于部署参考与线上问题快速处理。
