# 03 | 环境变量与配置覆盖机制

本模块介绍 Docker Compose 中 `.env` 文件、环境变量注入、配置覆盖文件（`override.yml`）的使用方法，帮助实现灵活的多环境配置能力，满足开发、测试、生产等不同场景需求。

---

## 📌 使用场景

- 同一套 Compose 配置，在不同环境中使用不同端口、密码、镜像标签
- 希望将配置抽离出代码逻辑，实现“配置即部署”
- 在 CI/CD 流水线中动态注入环境变量与覆盖策略

---

## 🎯 目标

- 使用 `.env` 管理默认环境变量
- 在 Compose 文件中动态引用变量
- 使用 `docker-compose.override.yml` 实现配置覆盖
- 了解变量优先级与作用域

---

## 📦 示例 1：使用 `.env` 注入变量

### 📁 文件结构

```yaml
myapp/
├── docker-compose.yml
└── .env
```

### 📝 .env 文件示例

```env
NGINX_PORT=8080
MYSQL_ROOT_PASSWORD=123456
APP_ENV=development
```

### 📝 docker-compose.yml 示例

```yaml
version: "3.8"

services:
  web:
    image: nginx
    ports:
      - "${NGINX_PORT}:80"

  db:
    image: mysql
    environment:
      - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
```

---

## 📦 示例 2：使用 override 文件覆盖配置

Compose 默认会自动合并同目录下的 `docker-compose.override.yml`，用于在不同环境下局部覆盖配置项。

### 📝 docker-compose.override.yml 示例

```yaml
services:
  web:
    ports:
      - "3000:80"
    environment:
      - DEBUG=true
```

### 启动命令（自动合并）

```bash
docker-compose up -d
```

### 自定义多个覆盖文件

```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

---

## 🔄 变量优先级（从高到低）

1. CLI 命令中显式定义的变量（如 `MY_VAR=value docker-compose up`）
2. shell 中已有的环境变量
3. `.env` 文件中的变量
4. Compose 文件中默认值（`${VAR:-default}`）

---

## 🧪 验证方式

查看变量是否被正确解析：

```bash
docker-compose config
```

可输出完整展开后的 Compose 配置内容。

---

## 🚨 常见问题排查

| 问题描述   | 排查建议                                            |
| ---------- | --------------------------------------------------- |
| 变量未生效 | 检查 `.env` 文件是否在 Compose 文件同目录           |
| 变量为空   | 使用默认值语法：`${VAR:-default}`                   |
| 覆盖未生效 | 覆盖文件字段需结构一致才会生效（如 `ports` 为数组） |

---

## 🧠 拓展知识点

- 将多个 `.env` 文件按环境命名：`.env.dev`、`.env.prod`
- 使用 `--env-file` 明确指定加载配置
- 配合 CI 工具动态渲染 env 文件（如 GitHub Actions secrets）

---

> 📁 下一模块：Compose 最佳实践与问题排查 → [04-best-practices.md](./04-best-practices.md)
