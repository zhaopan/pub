# trojan | Trojan 配置与部署实战手册

本文件为 Trojan 高性能加密代理工具的配置使用记录，涵盖：

- ✅ 配置文件结构说明
- ✅ TLS 证书配置
- ✅ 启动方式与防火墙配置
- ✅ 实战部署经验与误区排查

---

## 📁 路径与服务

- 配置文件路径：`/etc/trojan/config.json`
- 启动命令：`systemctl start trojan` / `systemctl enable trojan`
- 日志查看：`journalctl -u trojan -f`

---

## 🧩 配置文件结构（基本模板）

```json
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": 443,
  "remote_addr": "127.0.0.1",
  "remote_port": 80,
  "password": [
    "your_strong_password"
  ],
  "ssl": {
    "cert": "/etc/ssl/certs/fullchain.pem",
    "key": "/etc/ssl/private/privkey.pem",
    "sni": "your.domain.com"
  }
}
```

---

## 🔐 证书配置说明

- 推荐使用 `acme.sh` 或 `certbot` 获取 Let’s Encrypt 免费证书
- cert 路径建议为 `/etc/letsencrypt/live/domain/` 下的软链
- Trojan 必须启用 TLS，不能工作于明文模式！

---

## 🔁 客户端配置要点（参考）

```json
{
  "remote_addr": "your.server.ip",
  "remote_port": 443,
  "password": ["your_strong_password"],
  "ssl": {
    "verify": true,
    "sni": "your.domain.com"
  }
}
```

---

## 🛡️ 防火墙设置建议

```bash
ufw allow 443
ufw allow OpenSSH
```

或 CentOS：

```bash
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
```

---

## 🧪 实战经验：Trojan + Nginx 共存

目标：

- Trojan 监听 443，Nginx 监听 80/其他端口或使用 Unix socket

注意事项：

- 若使用同一端口需配置 SNI 区分（较复杂）
- 通常直接使用 Trojan 反代至本地服务（如：Nginx → Unix socket）

---

## 🛠️ 常见问题与排查建议

| 问题               | 原因                      | 解决方案                              |
| ------------------ | ------------------------- | ------------------------------------- |
| 客户端连接失败     | 密码错误 / 域名证书不一致 | 检查 password 与 SNI                  |
| 443 无响应         | 服务未启动 / 证书错误     | 查看 `journalctl -u trojan`           |
| 连接成功但无法上网 | 转发端口未配置            | 检查 `remote_addr` 与本地服务是否可达 |

---

## 🧠 历史经验与踩坑记录

- 证书过期后 Trojan 将拒绝所有连接，建议设置自动续期脚本
- TLS 证书路径权限需对 Trojan 用户可读
- 与其他 HTTPS 服务冲突时，使用 Unix socket 避免端口占用
- 建议搭配 Cloudflare Zero Trust 使用，提高隐蔽性和连接稳定性

> 📁 本文档建议归档于 `/software/full-config/trojan-deep.md`，用于翻墙、代理、安全部署参考。
