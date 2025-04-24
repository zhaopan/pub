# 06 | Shell 脚本片段合集

本模块汇总了日常开发、部署、排查中常用的 Shell 脚本片段与模版，包括自动化初始化、批量处理、条件判断等操作逻辑。

> 📌 注：所有脚本片段均来自历史项目实战或终端备忘，**注释即为记忆辅助，请务必保留！**

---

## 🚀 脚本结构基础

```bash
#!/bin/bash

echo "Start running script..."

if [ -f /etc/nginx/nginx.conf ]; then
  echo "nginx 配置存在"
else
  echo "配置缺失，退出"
  exit 1
fi
```

---

## 🔁 for 循环批处理

```bash
for file in *.log; do
  echo "处理日志文件: $file"
  gzip "$file"
done
```

---

## 🔂 while + read 逐行处理

```bash
cat list.txt | while read line; do
  echo "当前行：$line"
done
```

---

## ⏱️ 计划任务初始化脚本片段

```bash
echo "0 0 * * * /usr/local/bin/backup.sh" >> /etc/crontab
systemctl restart cron
```

---

## 📂 目录初始化脚本

```bash
#!/bin/bash
for d in logs data tmp; do
  mkdir -p "/var/myapp/$d"
done
chown -R www-data:www-data /var/myapp
```

---

## 🧪 执行命令结果判断

```bash
#!/bin/bash
curl -s http://localhost:8080 > /dev/null
if [ $? -ne 0 ]; then
  echo "接口异常"
  exit 1
fi
```

---

## 🧠 历史注释说明

- `gzip *.log` 脚本用于早期线下日志压缩归档，每周跑一次
- `while read` 是处理 IP 黑名单或机器清单常用写法
- `if [ $? -ne 0 ]` 出现在所有脚本的“健康探针”中
- `crontab` 初始化脚本曾用作服务器首次部署自动装入定时任务

---

> 📁 下一模块：legacy | 历史命令收录（包含大量注释） → [legacy.md](./legacy.md)
