# pure-ftpd | Pure-FTPd 配置（完整实战版）

本文件是 `pure-ftpd` 的详细配置实战手册，涵盖：

- ✅ 配置文件结构说明
- ✅ 虚拟用户配置实践
- ✅ 被动模式设置 + 防火墙建议
- ✅ 问题排查经验

---

## 📁 配置结构说明

- 主配置路径：`/etc/pure-ftpd/`
- 配置方式：多数配置为“单行文件 + 值”，如：
  - `/etc/pure-ftpd/conf/ChrootEveryone` → `yes`
  - `/etc/pure-ftpd/conf/PassivePortRange` → `40110 40210`
- 启动方式：`systemctl restart pure-ftpd`

---

## 🧩 常见配置段

### ✅ 被动端口配置（建议）

```bash
echo "40110 40210" > /etc/pure-ftpd/conf/PassivePortRange
```

- 配合防火墙放行该端口范围：

```bash
ufw allow 40110:40210/tcp
```

---

### ✅ 强制虚拟用户禁锢目录

```bash
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
```

### ✅ 创建虚拟用户并绑定真实系统账号

```bash
pure-pw useradd ftpuser -u www-data -d /home/ftpuser
pure-pw mkdb                        # 更新数据库
/etc/init.d/pure-ftpd restart      # 重启服务使其生效
```

> ⚠️ 绑定系统用户时务必设置目录权限为 `750` 或 `755`，确保能访问

---

## 🧪 实战部署：用于 CI 自动上传构建产物

背景：

- 每次前端构建后通过 FTP 上传到站点服务器
- 为避免系统用户泄露，仅启用虚拟用户 + 被动端口 + 限定目录

做法：

- 用 `pure-pw` 添加只读虚拟账户
- 主机防火墙 + FTP 服务开放固定被动端口（40110-40210）
- 通过脚本使用 `lftp` 进行上传自动化

---

## 🛠️ 常见故障与排查建议

| 问题                   | 原因                  | 解决方案                            |
| ---------------------- | --------------------- | ----------------------------------- |
| 登录成功但文件列表为空 | 被动端口未放行        | 检查 PassivePortRange + 防火墙      |
| 上传失败权限错误       | 目标目录属主问题      | 确保用户绑定的系统账号拥有写权限    |
| 创建用户后无效         | 未执行 `pure-pw mkdb` | 每次添加用户都需更新数据库          |
| 中文乱码               | 客户端编码不一致      | 配置 UTF-8 支持（或设置 lftp 编码） |

---

## 🧠 历史注释与经验

- 曾因 `mkdb` 忘执行导致创建的用户无效调试了近 1 小时
- FTP 被动端口未放通在 AWS/GCP 中尤为常见，无法列出目录
- 配置文件均为单行文本文件，误改目录名会导致服务启动失败
- 为安全考虑，建议添加 Fail2Ban 阻止 FTP 爆破行为

> 📁 本文档适合收藏于 `/software/full-config/` 模块，作为长期部署/调试文档使用。
