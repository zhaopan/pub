# caddy | Caddy 配置实战手册（自动 HTTPS）

本文件为 Caddy Web Server 的详细配置文档，涵盖：

- ✅ 基本配置语法与结构
- ✅ 自动 HTTPS 与 Let's Encrypt 整合
- ✅ 多站点 / 反向代理 / 文件服务用法
- ✅ 日志与排错建议

---

## 📁 文件结构与启动方式

- 配置文件默认：`/etc/caddy/Caddyfile`
- 内容结构为域名块组合，每个域名一个服务单元
- 启动方式：

```bash
systemctl restart caddy
journalctl -u caddy -f
```

---

## 🧩 基本配置结构

```caddy
example.com {
    root * /var/www/example
    file_server
}
```

说明：

- `root` 设置根目录
- `file_server` 开启静态文件服务
- 默认自动开启 HTTPS（需 80 / 443 可用）

---

## 🔁 反向代理配置（前后端分离）

```caddy
api.example.com {
    reverse_proxy 127.0.0.1:3000
}
```

可选增强：

```caddy
reverse_proxy 127.0.0.1:3000 {
    header_up Host {host}
    header_up X-Real-IP {remote}
}
```

---

## 🔐 自定义 HTTPS 证书

```caddy
example.com {
    tls /etc/ssl/my.crt /etc/ssl/my.key
    reverse_proxy 127.0.0.1:3000
}
```

---

## 🧪 多站点 + 自动 HTTPS + 反代实战

背景：

- 有 3 个服务运行在不同端口，需统一接入 TLS，并设置默认目录

Caddyfile 配置：

```caddy
main.example.com {
    reverse_proxy localhost:8080
}

api.example.com {
    reverse_proxy localhost:3000
}

static.example.com {
    root * /var/www/static
    file_server
}
```

说明：

- 只要域名解析正常、端口开放，Caddy 自动申请 HTTPS
- 每个域名块都独立处理，不冲突

---

## 📈 日志与状态配置

```caddy
log {
    output file /var/log/caddy/access.log
    format console
    level INFO
}
```

---

## 🛠️ 常见问题排查建议

| 问题                       | 原因                       | 解决方案                        |
| -------------------------- | -------------------------- | ------------------------------- |
| 证书申请失败               | 80/443 被占用或防火墙阻止  | 确保端口未被其他服务占用        |
| 自动跳转 HTTP→HTTPS 不生效 | 域名未指向当前服务器       | 检查 DNS 与防火墙配置           |
| 服务无法访问               | Caddy 配置错误或后端未启动 | 查看 `journalctl -u caddy` 输出 |

---

## 🧠 经验与踩坑记录

- 默认 HTTPS 自动化极为强大，适合部署 Landing Page、前端站点
- 配置结构简单但不容混写，建议每个域名单独写块
- 多服务监听多个端口时，务必确保被反代的服务已启动，否则 Caddy 会直接 502

> 📁 本文档建议归档于 `/software/full-config/caddy-deep.md`，适用于轻量级 HTTPS 部署、Web 运维参考。
