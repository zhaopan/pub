# 04 | 系统进程与服务管理

本模块整理了进程查看、服务控制、后台运行、信号终止等常用系统管理命令。涵盖 `ps` / `top` / `kill` / `nohup` / `systemctl` / `journalctl` 等操作。

> 📌 注：命令来源多为生产调试或部署脚本，注释信息极具参考意义，请完整保留！

---

## 🔍 查看进程信息

```bash
ps aux | grep nginx                   # 查找 nginx 相关进程（全量进程 + 过滤）
ps -ef | grep java                    # 类似用法，常用于查找 JVM 应用
top                                   # 实时查看进程资源消耗
htop                                  # 高级 top 工具（需单独安装）
pidof nginx                           # 获取 nginx 主进程 ID
```

---

## 🧨 杀死进程

```bash
kill -9 <pid>                         # 强制杀死指定进程
killall node                          # 杀死所有 node 进程
pkill -f "gunicorn"                   # 根据进程名（包含参数）匹配终止
```

---

## 🔧 后台运行脚本 / 守护进程方式

```bash
nohup node server.js > out.log 2>&1 &   # 后台运行 Node 项目，输出到日志文件
jobs                                    # 查看后台任务
fg %1                                   # 将后台任务恢复至前台
disown                                  # 从 shell 移除后台任务（不受终端影响）
```

---

## 🔌 systemd 服务控制（新系统）

```bash
systemctl start nginx.service         # 启动服务
systemctl stop nginx.service          # 停止服务
systemctl restart nginx               # 重启服务（可省略 .service）
systemctl status nginx                # 查看服务状态
systemctl enable nginx                # 设置开机自启
systemctl disable nginx               # 取消开机自启
```

---

## 🧾 查看日志（含 journalctl）

```bash
journalctl -xe                        # 查看最近报错信息（可实时刷新）
journalctl -u nginx.service           # 查看指定服务日志
tail -f /var/log/syslog               # 传统日志方式
```

---

## 🧠 历史注释说明

- `nohup node app.js` 最早用于部署内网测试服务（未配置 systemd）
- `disown` 解决了终端退出后程序被杀死的问题（非 tmux）
- `journalctl -xe` 曾用于排查 systemctl 启动失败原因（语法/权限）
- `pkill -f` 被用于 kill gunicorn + uvicorn 混合服务，常规 `kill` 无效

---

> 📁 下一模块：文本处理与正则技巧 → [05-text-regex.md](./05-text-regex.md)
