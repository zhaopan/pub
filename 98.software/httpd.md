# httpd | Apache HTTPD 配置实战手册

本文件为 Apache（httpd）服务配置与使用的详细文档，涵盖：

- ✅ 主配置结构与虚拟主机写法
- ✅ 重定向、反代、目录权限控制
- ✅ 配合 `.htaccess` 的动态控制
- ✅ 常见报错排查与性能建议

---

## 📁 配置结构说明

- 主配置文件：`/etc/httpd/conf/httpd.conf`
- 虚拟主机文件夹：`/etc/httpd/conf.d/`
- 默认站点目录：`/var/www/html`
- 启动命令：`systemctl restart httpd`

---

## 🧩 虚拟主机配置示例

```apache
<VirtualHost *:80>
  ServerName site.local
  DocumentRoot /var/www/site

  <Directory /var/www/site>
    AllowOverride All
    Require all granted
  </Directory>

  ErrorLog /var/log/httpd/site_error.log
  CustomLog /var/log/httpd/site_access.log combined
</VirtualHost>
```

> ✅ `AllowOverride All` 允许 `.htaccess` 生效

---

## 🔁 重定向 & 反向代理配置

### 301 跳转 HTTPS

```apache
<VirtualHost *:80>
  ServerName www.example.com
  Redirect permanent / https://www.example.com/
</VirtualHost>
```

### 反向代理到后端服务

```apache
<VirtualHost *:80>
  ServerName api.example.com

  ProxyPreserveHost On
  ProxyPass / http://127.0.0.1:3000/
  ProxyPassReverse / http://127.0.0.1:3000/
</VirtualHost>
```

---

## 🔐 目录访问控制

```apache
<Directory "/var/www/private">
  AuthType Basic
  AuthName "Restricted Content"
  AuthUserFile /etc/httpd/.htpasswd
  Require valid-user
</Directory>
```

生成密码文件：

```bash
htpasswd -c /etc/httpd/.htpasswd username
```

---

## 🧪 实战场景：解决 Laravel rewrite 失败

背景：

- Laravel 项目部署后访问首页正常，子路径 404

修复方式：

- 配置 `.htaccess` 启用 rewrite
- 虚拟主机启用：

```apache
<Directory /var/www/laravel>
  AllowOverride All
</Directory>
```

---

## 🛠️ 常见故障排查建议

| 问题             | 原因                 | 解决方案                           |
| ---------------- | -------------------- | ---------------------------------- |
| 403 Forbidden    | 权限不足 / 索引缺失  | 检查 DocumentRoot 目录权限         |
| .htaccess 不生效 | AllowOverride 未设置 | 虚拟主机中启用 `AllowOverride All` |
| 无法反代后端服务 | mod_proxy 模块未加载 | `a2enmod proxy` + proxy_http 启用  |

---

## 🧠 历史经验注释

- `Directory` 中设置权限比全局灵活，适合控制单站点行为
- `.htaccess` 文件控制路径重写、缓存、阻止访问等功能关键
- 使用 `curl -I` 验证 HTTP 响应头是否重定向生效
- Apache 默认不显示目录列表，需显式开启：`Options +Indexes`

> 📁 本文档建议归档于 `/software/full-config/httpd-deep.md`，适用于 Apache 站点部署/排错指南。
