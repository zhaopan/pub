# 04 | Docker Compose 最佳实践与问题排查

本模块汇总使用 Docker Compose 时的最佳实践经验，涵盖命令行使用技巧、配置结构优化建议、跨环境策略、常见错误排查与用户实际示例（`docker-compose-cli-eg`）的详细解析。

---

## 📌 使用场景

- 多人协作管理 Compose 文件时确保清晰一致
- 提升项目部署的可维护性与可迁移性
- 快速应对容器异常、配置失效、变量未注入等问题

---

## 🎯 目标

- 熟练掌握 Compose CLI 的主要用法
- 梳理 `docker-compose` 项目的结构规范与使用模式
- 提供实际示例帮助快速定位和排查问题

---

## ⚙️ CLI 常用命令汇总（cli-list）

| 命令                                 | 说明                        |
| ------------------------------------ | --------------------------- |
| `docker-compose up -d`               | 后台启动所有服务            |
| `docker-compose down`                | 停止并清除服务容器          |
| `docker-compose logs -f`             | 实时查看所有服务日志        |
| `docker-compose exec <service> bash` | 进入指定容器交互终端        |
| `docker-compose config`              | 检查配置合并与语法          |
| `docker-compose ps`                  | 查看服务状态                |
| `docker-compose build`               | 构建镜像（配合 build 字段） |
| `docker-compose restart`             | 重启服务                    |
| `docker-compose pull`                | 拉取镜像                    |
| `docker-compose stop/start`          | 分别停止或启动服务          |

---

## 🔍 docker-compose-cli-eg 示例详解

以下示例展示多个 CLI 命令组合使用的典型方式，适合日常项目调试与部署运维场景。

### ✅ 示例 1：首次拉起项目

```bash
# 构建镜像 + 启动容器
docker-compose up -d --build

# 实时查看日志
docker-compose logs -f
```

---

### ✅ 示例 2：进入容器调试 + 查看网络配置

```bash
# 进入容器终端
docker-compose exec web bash

# 查看当前网络结构
docker-compose network ls
docker-compose network inspect <network_name>
```

---

### ✅ 示例 3：测试服务通信

```bash
# 在 web 容器内 ping db 容器名
docker-compose exec web ping db
```

---

### ✅ 示例 4：环境变量调试

```bash
# 显示合并后配置与变量解析效果
docker-compose config
```

---

## 🧩 最佳实践建议

### 📌 配置规范建议

- 所有 `docker-compose.yml` 均版本管（建议与代码放同 repo）
- `.env` 文件应设置默认值、避免硬编码敏感信息
- 不同环境拆分多个 override 文件（如 dev、prod）

### 📌 文件结构推荐

```yaml
project/
├── docker-compose.yml
├── docker-compose.override.yml
├── .env
├── nginx/
├── php/
└── www/
```

### 📌 Git 配置建议

- `.env` 可以提交 `.env.example` 作为模板
- `.env` 可通过 `.gitignore` 屏蔽，实际部署时复制使用

---

## 🚨 常见问题排查

| 问题           | 排查建议                                                |
| -------------- | ------------------------------------------------------- |
| 容器间无法通信 | 检查是否在同一网络、自定义 network 是否配置正确         |
| `.env` 无效    | 确保文件名为 `.env` 且与 compose 文件在同级目录         |
| 启动报错       | 使用 `docker-compose config` 查阅是否语法错误或路径缺失 |
| 映射端口无效   | 确保 host 端口未被占用、防火墙未阻挡                    |

---

## 🧠 拓展建议

- 推荐结合 Makefile、Shell 脚本封装常用操作
- 引入 `profiles` 功能实现服务模块分层启停（v3.9+）
- 结合 GitLab CI、GitHub Actions 实现流水线部署 Compose 项目
- 对接 `docker context` 支持远程主机部署

---

> 📁 下一模块建议：撰写模块 `README.md` 与模块总览索引。
