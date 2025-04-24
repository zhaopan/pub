# 01 | Docker Compose 多容器应用基础实践

本模块介绍如何通过 Docker Compose 定义和运行一个包含多个服务的容器应用。通过 `docker-compose.yml` 文件，开发者可以声明服务、网络、卷和环境变量，从而实现一键部署与协同管理。

---

## 📌 使用场景

- 构建包含多个组件（如前端、后端、数据库）的应用开发环境
- 替代多条 `docker run` 命令，统一管理多个服务容器
- 本地调试、测试、自动化部署等场景的最佳实践工具

---

## 🎯 目标

- 理解 Compose 的工作原理与目录结构
- 编写并运行一个典型的多容器应用（如 Nginx + PHP + MySQL）
- 掌握 `docker-compose up/down`、日志、重启策略等核心操作

---

## 📦 示例：搭建 Nginx + PHP + MySQL 应用栈

### 📁 项目结构示例

```yaml
myapp/
├── docker-compose.yml
├── nginx/
│   └── default.conf
├── php/
│   └── Dockerfile
└── www/
    └── index.php
```

### 📝 docker-compose.yml 示例

```yaml
version: "3.8"

services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
      - ./www:/var/www/html
    depends_on:
      - php

  php:
    build: ./php
    volumes:
      - ./www:/var/www/html

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: 123456
    volumes:
      - db-data:/var/lib/mysql

volumes:
  db-data:
```

---

## 🔧 操作命令

### 启动服务

```bash
docker-compose up -d
```

### 停止并清理服务

```bash
docker-compose down
```

### 查看容器日志

```bash
docker-compose logs -f
```

---

## 🧪 验证方式

- 访问 [http://localhost:8080](http://localhost:8080)
- 确保 PHP 脚本在 `www/index.php` 中生效
- 使用 `docker ps` 查看三个容器是否都正常运行

---

## 🚨 常见问题排查

| 问题描述             | 处理建议                                 |
| -------------------- | ---------------------------------------- |
| 页面 502 Bad Gateway | 检查 Nginx 配置与 PHP 服务是否联通       |
| MySQL 无法连接       | 确认环境变量、容器网络是否正确           |
| 文件挂载无效         | 检查路径拼写及权限设置，建议使用绝对路径 |

---

## 🧠 拓展知识点

- 使用 `.env` 管理环境变量配置
- `depends_on` 仅影响启动顺序，不代表健康检查
- 可以结合 `docker-compose.override.yml` 进行环境覆盖

---

> 📁 下一模块：Compose 文件结构与字段详解 → [02-compose-file.md](./02-compose-file.md)
