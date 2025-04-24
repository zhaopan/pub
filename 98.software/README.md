# 软件配置实战手册（/software/full-config）

本目录收录了各类核心软件的**完整实战配置文档**，涵盖安装路径、常用配置片段、常见问题排查与历史经验注释，适用于长期运维维护、快速查阅、环境初始化参考。

---

## 📦 索引总览

| 软件模块     | 文档文件                       | 内容概要                                 |
| ------------ | ------------------------------ | ---------------------------------------- |
| Nginx        | [nginx.md](./nginx.md)         | 静态托管 / 反代配置 / 多站点 HTTPS 实战  |
| Pure-FTPd    | [pure-ftpd.md](./pure-ftpd.md) | 虚拟用户配置 / 被动端口 / 权限与服务     |
| Vim          | [vim.md](./vim.md)             | `.vimrc` 配置 / 插件管理 / 快捷键习惯    |
| 腾讯云       | [qcloud.md](./qcloud.md)       | CLI 使用 / 镜像管理 / 安全组与部署流程   |
| EasyBCD      | [easybcd.md](./easybcd.md)     | 双系统引导配置 / GRUB 恢复 / BCD 备份    |
| MySQL        | [mysql.md](./mysql.md)         | 权限 / 主从配置 / 数据恢复 / 查询优化    |
| Redis        | [redis.md](./redis.md)         | 密码保护 / AOF / maxmemory 策略与防误删  |
| Apache HTTPD | [httpd.md](./httpd.md)         | 虚拟主机 / .htaccess / rewrite 重定向    |
| Caddy        | [caddy.md](./caddy.md)         | 自动 HTTPS / 多站反代 / 静态文件部署     |
| Trojan       | [trojan.md](./trojan.md)       | TLS 加密代理配置 / 客户端对接 / 证书管理 |

---

## 🧠 使用建议

- 📁 可作为项目私有手册、部署参考、团队知识同步用
- 💬 建议结合实际服务器配置实时验证
- 🗂️ 支持批量维护配置模板、初始化脚本、容器封装等延伸内容

> 📌 所有文档均保留历史注释与真实踩坑背景，实战导向，非示意性配置。
