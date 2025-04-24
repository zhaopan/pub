# 04 | 容器网络配置与互联通信

本模块介绍 Docker 中的网络通信机制，涵盖默认网络模式、容器互联方案、自定义网络的创建与使用，适用于本地开发、多容器协同、微服务等场景。

---

## 📌 使用场景

- 多个容器（如前端、后端、数据库）之间需要直接通信
- 希望隔离不同项目的容器网络空间
- 配置特定端口映射规则或外部访问策略

---

## 🎯 目标

- 掌握 Docker 网络模型及默认行为
- 使用 bridge 网络实现容器间通信
- 创建自定义网络以实现容器名称互通

---

## 🌐 Docker 网络模式概览

| 网络模式    | 说明                                  |
| ----------- | ------------------------------------- |
| `bridge`    | 默认网络模式，容器间可通过 IP 通信    |
| `host`      | 容器共享宿主机网络，不隔离            |
| `none`      | 无网络连接                            |
| `container` | 与指定容器共享网络命名空间            |
| 自定义网络  | 用户自定义的可命名网络，支持 DNS 互通 |

---

## 📦 示例 1：默认 bridge 网络下容器互访

启动两个容器：

```bash
docker run -d --name web1 nginx
docker run -d --name web2 nginx
```

使用命令查看 IP 地址：

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web1
```

在 web2 容器内 ping web1：

```bash
docker exec -it web2 ping <web1_ip>
```

> 默认 bridge 网络 **不支持容器名 DNS 互通**

---

## 📦 示例 2：自定义网络 + 容器名称互通

创建网络：

```bash
docker network create app-net
```

使用网络启动容器：

```bash
docker run -d --name frontend --network app-net nginx
docker run -d --name backend --network app-net httpd
```

验证互通：

```bash
docker exec -it frontend ping backend
```

> 在自定义网络中，容器可通过“名称”互相解析，推荐使用。

---

## 🔧 网络管理命令

- 查看所有网络：`docker network ls`
- 查看网络详情：`docker network inspect <网络名>`
- 删除网络：`docker network rm <网络名>`

---

## 🚨 常见问题排查

| 问题描述             | 排查建议                         |
| -------------------- | -------------------------------- |
| 容器无法互通         | 检查是否使用了同一个网络         |
| ping 不通容器名称    | bridge 网络默认不支持容器名解析  |
| 外部无法访问容器服务 | 确保正确暴露端口并映射至主机端口 |

---

## 🧠 拓展知识点

- 配合 Docker Compose 管理网络与服务编排
- 配置网络别名（`--network-alias`）提高可维护性
- 使用 `host` 模式绕过端口映射，适合开发调试阶段

---

> 📁 下一模块：Docker 常见问题汇总与排错 → [05-troubleshooting.md](./05-troubleshooting.md)
