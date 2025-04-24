# 02 | 权限与用户管理

本模块整理了 Linux 中与文件权限、用户/组管理、sudo 权限相关的命令与配置操作，适用于本地开发环境、安全排查、服务器初始化等场景。

> 📌 注：部分命令来源于历史项目搭建、线上调试或多用户测试环境，请完整保留命令与注释！

---

## 🔐 文件与目录权限

```bash
ls -l /etc/passwd                    # 查看权限信息（文件所有者、组、权限位）
chmod +x run.sh                      # 添加执行权限
chmod 644 config.yml                 # 设置为：rw-r--r--
chmod -R 755 /var/www                # 递归设置目录权限
chown root:root config.yml           # 修改文件所有者为 root 用户和组
chown -R www-data:www-data ./html    # 网站目录批量授权给 Nginx 用户
```

---

## 👥 用户与组管理

```bash
useradd -m devuser                 # 创建用户并生成 home 目录
passwd devuser                     # 设置用户密码
usermod -aG sudo devuser           # 将用户添加至 sudo 组
groupadd developers                # 创建用户组
gpasswd -a eric developers         # 将 eric 添加到 developers 组
id devuser                         # 查看用户的 UID、GID 和附属组
```

---

## ⚙️ sudo 权限与提权配置

```bash
sudo visudo                        # 安全编辑 sudoers 文件（推荐用 visudo）
sudo cat /etc/sudoers              # 查看完整权限规则
```

### 📝 示例：允许 devuser 免密码执行某脚本

```bash
devuser ALL=(ALL) NOPASSWD: /usr/local/bin/deploy.sh
```

---

## 🧠 历史注释说明

- `chmod +x` 是早期执行 shell 脚本时常犯错的地方（报错：Permission denied）
- `usermod -aG sudo xxx` 在新用户无法 sudo 的初始化脚本中至关重要
- `chown -R www-data` 曾用于手动部署 Laravel 项目目录权限修复
- `gpasswd` 替代了旧的 `adduser username group` 的方式，更为准确

---

> 📁 下一模块：网络调试与远程管理 → [03-network-tools.md](./03-network-tools.md)
