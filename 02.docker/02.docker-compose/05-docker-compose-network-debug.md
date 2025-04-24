# 05 | Docker Compose 容器网络排查与调试指南（进阶版）

在 Docker Compose 编排多容器服务时，容器间网络通信是实现服务协作的基础。但在实际操作中，DNS 不通、连接被拒、端口未映射等问题频发，尤其在涉及 **自定义网络** 和 **容器 IP 地址定位** 时尤为常见。

本指南从网络调试的角度出发，深入解析 Compose 中的网络结构、服务名称与 DNS、容器之间的互联机制，重点覆盖：**如何加入已有网络、如何排查 IP 映射与网络可达性问题**。

---

## 📌 使用场景

- 容器间网络无法通信（Ping 不通 / 应用连接失败）
- 一个服务需要接入已有网络（如 Traefik、外部数据库）
- 多个 Compose 项目之间需要打通通信
- 需要分析容器真实 IP 或端口是否可达

---

## 🎯 核心目标

- 识别 Compose 自动生成网络与用户自定义网络
- 掌握在 Compose 中连接多个网络的方法
- 使用命令检查容器 IP、别名、主机名、端口映射
- 提供典型场景下的排查与测试策略

---

## 🌐 默认 vs 自定义网络

### 默认网络行为

```yaml
services:
  app:
    image: myapp
  db:
    image: mysql
```

- Compose 会自动创建一个名为 `<项目名>_default` 的网络
- 所有服务默认加入此网络，服务名可作为 DNS 主机名（如 `db:3306`）

---

## 🔧 加入已有网络（手动指定）

### 创建共享网络

```bash
docker network create shared-net
```

### Compose 中显式引用已有网络

```yaml
services:
  app:
    image: myapp
    networks:
      - default
      - shared-net

networks:
  default:
  shared-net:
    external: true
```

> 说明：
>
> - `default` 是自动生成的网络
> - `shared-net` 是已存在的外部网络，需手动声明 `external: true`
> - 此时容器 `app` 同时可访问两个网络空间的服务

---

## 🧪 网络调试命令合集

### 查看网络及容器 IP 分配

```bash
docker network ls
docker network inspect <network-name>
```

### 查看容器 IP 地址（简洁版）

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name>
```

### 进入容器内部测试 DNS / IP

```bash
docker-compose exec app ping db
docker-compose exec app curl http://db:3306
```

### 查看网络中 DNS 映射别名

```bash
docker network inspect shared-net | grep -A 10 Containers
```

---

## ✅ 实战示例：接入 Traefik 网络实现反向代理

```yaml
services:
  app:
    image: myapp
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.app.rule=Host(`myapp.local`)"
    networks:
      - default
      - traefik-proxy

networks:
  default:
  traefik-proxy:
    external: true
```

> 说明：
>
> - `traefik-proxy` 是主代理项目创建的网络
> - 当前项目加入此网络后，Traefik 可通过 DNS 找到该服务

---

## 🛠️ 网络通信排查 checklist

| 问题场景         | 排查建议                                      |
| ---------------- | --------------------------------------------- |
| 服务名 Ping 不通 | 是否加入同一个网络？是否拼写正确？            |
| 服务连接被拒     | 服务是否监听对应端口？是否 `expose`/`ports`？ |
| curl 报 DNS 错误 | 网络未加载/未绑定容器别名                     |
| 外部访问失败     | 主机端口是否开放？是否正确映射？              |
| 多项目互通失败   | 是否加入共享 external 网络？                  |

---

## 🧠 建议实践

- 多服务项目建议使用自定义命名网络提升隔离与可控性
- 不建议硬编码容器 IP，优先使用服务名进行通信
- 网络调试工具推荐安装：`iputils-ping`, `curl`, `net-tools`, `telnet`, `dig`
- 可在 CI/CD 阶段加入 `docker-compose config` 验证网络结构完整性

---

> 📁 本文建议作为 `network-debug.md` 长期维护，适合放入高级实战或故障定位子模块中。
