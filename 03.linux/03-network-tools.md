# 03 | 网络调试与远程管理

本模块整理了常用的网络诊断命令与远程主机交互工具，如 ping、netstat、curl、ssh、scp 等，适用于联通性排查、端口测试、服务连接验证等常见场景。

> 📌 注：本模块包含部分历史命令与排障场景备注，请**保留全部注释**！

---

## 🌐 网络测试与诊断工具

```bash
ping 8.8.8.8                             # 测试外网连通性（Google DNS）
ping baidu.com                           # 测试域名解析与连通性
curl ifconfig.me                         # 查看公网 IP
curl -I http://example.com               # 查看 HTTP 响应头
telnet 127.0.0.1 3306                    # 测试本机 MySQL 是否开放端口（旧版）
nc -zv 127.0.0.1 6379                    # 使用 netcat 测试端口连通性
```

---

## 🛠️ 网络连接与端口监听

```bash
netstat -tunlp                          # 查看所有监听端口与进程（已被 ss 替代）
ss -tulwn                               # 查看 TCP/UDP 状态，推荐新系统使用
lsof -i :8080                           # 查看端口对应进程
```

---

## 🔐 远程登录与传输工具

```bash
ssh user@192.168.1.100                  # SSH 登录远程主机
ssh -p 2222 user@remote.host            # 指定端口进行连接
scp file.txt user@192.168.1.100:/tmp/   # 上传文件至远程主机
scp user@host:/etc/nginx/nginx.conf ./  # 下载远程配置文件
rsync -avz ./src/ user@host:/opt/target # 使用 rsync 同步文件夹（更高效）
```

---

## 🧠 历史注释说明

- `ping baidu.com` 曾用于判断某海外服务器 DNS 是否配置正确
- `curl -I` 用于网站上线前进行响应头检查，如 301 跳转/缓存设置
- `netstat` 是早期最常用工具，但现代系统建议用 `ss` 替代
- `scp` 用于传输配置文件时，曾搭配 `vim scp://...` 实现远程编辑

---

> 📁 下一模块：系统进程与服务管理 → [04-process-systemctl.md](./04-process-systemctl.md)
