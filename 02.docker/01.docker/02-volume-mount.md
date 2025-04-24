# 02 | 数据卷挂载与配置映射

本模块介绍如何通过 Docker 的 `-v` 参数实现本地文件与容器内部目录的数据挂载，适用于持久化数据、注入配置文件等场景。

---

## 📌 使用场景

- 将本地配置文件映射至容器中，实现灵活配置替换
- 持久化容器内数据库或日志数据，防止数据丢失
- 多容器共享挂载目录，提升协作效率

---

## 🎯 目标

- 掌握 Volume 的挂载语法与两种模式（匿名卷 / 显式挂载）
- 实践挂载本地配置文件到容器中
- 演示挂载目录的双向可读写效果

---

## 📦 示例 1：挂载本地 nginx 配置文件

### 🔧 操作命令

```bash
docker run -d \
  --name nginx-config \
  -p 8081:80 \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
  nginx
```

### 参数说明

| 参数                    | 含义                                            |
| ----------------------- | ----------------------------------------------- |
| `-v`                    | 本地路径挂载至容器内路径（`主机路径:容器路径`） |
| `$(pwd)/nginx.conf`     | 当前目录下配置文件                              |
| `/etc/nginx/nginx.conf` | Nginx 默认主配置路径                            |

### 🧪 验证方式

- 修改本地配置后，重启容器查看变更效果
- 浏览器访问 `http://localhost:8081`

---

## 📦 示例 2：挂载目录用于数据持久化

```bash
docker run -d \
  --name mysql-volume \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -v $(pwd)/mysql-data:/var/lib/mysql \
  mysql:8.0
```

容器内的数据库数据将持久化保存在本地 `mysql-data` 目录中。

---

## 🚨 常见问题排查

| 问题描述       | 排查建议                                       |
| -------------- | ---------------------------------------------- |
| 配置未生效     | 检查挂载路径是否正确、配置语法是否兼容镜像版本 |
| 容器无法启动   | 宿主机目录权限不当，可尝试 `chmod -R 777` 测试 |
| 挂载文件为只读 | 加入 `:rw` 指定可读写：`-v xxx:/path:rw`       |

---

## 🧠 拓展知识点

- 匿名卷创建：`docker run -v /data busybox`
- 查看所有 Volume：`docker volume ls`
- 清理未使用 Volume：`docker volume prune`

---

> 📁 下一模块：自定义镜像构建与 Dockerfile → [03-custom-dockerfile.md](./03-custom-dockerfile.md)
