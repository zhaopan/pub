# 03 | 自定义镜像构建与 Dockerfile 实战

本模块介绍如何基于项目源码自定义构建 Docker 镜像，通过 `Dockerfile` 描述构建流程，适用于项目部署、环境封装、CI/CD 集成等场景。

---

## 📌 使用场景

- 打包前端/后端项目为独立镜像
- 自定义基础镜像、运行时环境、依赖安装逻辑
- 在 CI/CD 中实现自动构建镜像并推送至镜像仓库

---

## 🎯 目标

- 理解 `Dockerfile` 各指令含义及使用顺序
- 完成一个 Node.js 项目的镜像构建流程
- 掌握 `docker build`、`.dockerignore` 等工具的使用

---

## 📦 示例：构建一个 Node.js 服务镜像

### 📁 项目目录结构

```yaml
my-node-app/
├── app.js
├── package.json
├── Dockerfile
└── .dockerignore
```

### 📝 Dockerfile 示例

```Dockerfile
# 使用官方 Node 基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 拷贝依赖文件并安装
COPY package*.json ./
RUN npm install --production

# 拷贝代码
COPY . .

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["node", "app.js"]
```

---

## 🔧 构建与运行

### 构建镜像

```bash
docker build -t my-node-app:latest .
```

### 运行容器

```bash
docker run -d -p 3000:3000 --name node-app my-node-app:latest
```

---

## 🚫 忽略文件配置（.dockerignore）

避免将无关文件打包进镜像，示例：

```bash
node_modules
.git
*.log
.DS_Store
```

---

## 🧪 验证方式

浏览器访问：[http://localhost:3000](http://localhost:3000)
或使用 `curl` 工具进行接口验证。

---

## 🚨 常见问题排查

| 问题描述       | 排查建议                                             |
| -------------- | ---------------------------------------------------- |
| 容器内无效依赖 | 确保 package.json 和实际依赖一致，建议使用 `npm ci`  |
| 启动失败       | 通过 `docker logs <容器名>` 查看错误日志             |
| 镜像过大       | 使用更轻量的基础镜像如 `node:18-slim`、`alpine` 版本 |

---

## 🧠 拓展知识点

- 多阶段构建：优化构建体积和安全性
- 镜像压缩与缓存层优化技巧
- 使用 `docker tag` 和 `docker push` 管理镜像版本与推送仓库

---

> 📁 下一模块：容器网络通信与 bridge 网络 → [04-container-network.md](./04-container-network.md)
