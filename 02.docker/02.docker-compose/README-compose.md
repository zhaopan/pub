# 📦 Docker Compose 模块知识库

本模块聚焦于 Docker Compose 在开发、部署、调试等环节中的实战应用与工程规范。通过模块化结构，系统介绍从多容器编排基础、配置文件详解，到环境变量管理、CLI 使用技巧、网络调试等全链路能力，帮助工程师快速构建可维护、可扩展的容器化体系。

---

## 🧭 模块目录结构

| 编号 | 文件名                                                | 内容简介                                          |
| ---- | ----------------------------------------------------- | ------------------------------------------------- |
| 00   | [模块导语](./00-overview-compose.md)                  | 为什么你需要系统掌握 Docker Compose               |
| 01   | [多容器基础实践](./01-basic-usage.md)                 | 用 Compose 一键启动典型 Nginx + PHP + MySQL 应用  |
| 02   | [Compose 文件结构详解](./02-compose-file.md)          | docker-compose.yml 配置字段与语法详解             |
| 03   | [环境变量与覆盖机制](./03-env-override.md)            | `.env` 文件使用、变量优先级、override 文件结构    |
| 04   | [最佳实践与问题排查](./04-best-practices.md)          | CLI 实战、服务拆分建议、结构规范、常见问题汇总    |
| 05   | [网络调试专用指南](./docker-compose-network-debug.md) | 容器 IP、服务别名、共享网络、跨项目通信等进阶内容 |

---

## 🔧 推荐使用方式

- 📖 **模块化学习**：建议从 01 → 04 顺序阅读理解
- 🔍 **问题查阅**：遇到容器无法互通、变量失效等问题时直接跳转索引模块
- 🧱 **项目落地**：将模块内容应用于实际 Compose 项目中，结合 Git、CI/CD 等工具完成闭环

---

## 📘 推荐拓展方向

- 将 Compose 项目与 GitLab CI / GitHub Actions 集成
- 使用 Docker Secrets 管理敏感变量
- Compose + Traefik / Nginx Proxy Manager 实现自动 HTTPS 和服务暴露
- 学习 Docker Compose v2 CLI 语法（`docker compose`）

---

> 💡 本模块建议作为“可交付工程文档”发布至团队 Wiki、GitHub 知识仓库，适合长期维护和协作贡献。
