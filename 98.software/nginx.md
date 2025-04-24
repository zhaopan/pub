# nginx | Nginx 配置（完整实战版）

本文件是 `nginx` 的 **详细配置实战手册**，涵盖：

- ✅ 配置结构逐段说明
- ✅ 实战应用场景还原（部署、优化、安全等）
- ✅ 历史注释与踩坑细节
- ✅ 排查经验总结

> 📌 所有配置片段均为真实可用/已验证的内容，适用于长期维护知识库记录。

---

## 📁 配置结构说明

- 主配置文件：`/etc/nginx/nginx.conf`
- 站点配置（Debian 系）：`/etc/nginx/sites-available/` + `sites-enabled/`
- 日志位置：`/var/log/nginx/access.log`、`error.log`
- 模块 include 结构如下：

```nginx
http {
    include       mime.types;
    default_type  application/octet-stream;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```

---

## 🧩 常用配置场景

### 1. 静态资源部署

```nginx
server {
    listen 80;
    server_name static.example.com;

    root /var/www/static;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

### 2. 反向代理 Node 应用（Vite）

```nginx
server {
    listen 80;
    server_name app.example.com;

    location / {
        proxy_pass http://127.0.0.1:5173;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### 3. 配置 HTTPS（Let’s Encrypt）

```nginx
server {
    listen 443 ssl;
    server_name app.example.com;

    ssl_certificate /etc/letsencrypt/live/app.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/app.example.com/privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:3000;
    }
}
```

---

## 🧪 实战案例：多站点部署 + HTTPS 自动续期

背景：公司内部前后端分离，要求多站点、HTTPS 自动续期、统一 Nginx 管理。

做法：

- 使用 `certbot` + cron 定时续期
- 分站配置拆到 `sites-available`，软链进 `sites-enabled`
- 每次变更后执行：`nginx -t && systemctl reload nginx`

---

## 🛠️ 常见故障与排查建议

| 问题            | 原因                            | 解决方法                            |
| --------------- | ------------------------------- | ----------------------------------- |
| 403 Forbidden   | root 权限不足 / 缺少 index 文件 | 检查目录权限与索引文件              |
| 502 Bad Gateway | 被代理服务未启动 / 端口错误     | 检查代理服务状态                    |
| HTTPS 不生效    | 证书路径错误 / 权限不够         | 检查证书路径，确保 nginx 用户可访问 |

---

## 🧠 历史注释与踩坑记录

- 曾因 `proxy_pass` 后面少了 `/`，导致路径拼接出错（坑！）
- `ssl_certificate_key` 文件权限过高导致 Nginx 无法启动
- 多站点部署时忘记软链进 `sites-enabled` 导致配置无效
- `try_files` 是解决 Vue 路由 404 的关键一招
- 不同系统路径结构不同（Ubuntu vs CentOS），写文档时需特别标注

> 📁 本文档适合收藏于 `/software/full-config/` 模块，作为参考手册或团队 Wiki 公共文档使用。
