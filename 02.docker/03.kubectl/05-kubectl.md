# 📘 Kubernetes CLI：kubectl 实战指南

本模块系统整理 `kubectl` 工具在日常 Kubernetes 运维中的常用命令、排查技巧与最佳实践，适用于开发、测试、SRE 团队在多集群环境下的容器资源调试、部署与监控。

---

## 📌 使用场景

- 查询 Pod、Service、Deployment 等核心资源状态
- 进入容器内部排查问题，查看服务日志
- 配置与应用 YAML 文件，执行自动化部署
- 调试资源异常（如 CrashLoopBackOff、ImagePullBackOff 等）

---

## 🎯 目标

- 掌握核心命令：`get`、`describe`、`logs`、`exec`、`apply`
- 能够独立完成资源状态分析与容器内部调试
- 结合 YAML 实现 DevOps 持续部署与热更新
- 建立问题快速定位与恢复的排查体系

---

## 📦 常用命令结构速查

### 🎯 资源管理

```bash
kubectl get pods -A                  # 查看所有命名空间的 Pod
kubectl get svc -n default           # 查看默认命名空间的 Service
kubectl describe pod <pod-name>     # 查看 Pod 的详细状态与事件
kubectl delete pod <pod-name>       # 删除 Pod
```

### 🎯 日志与终端调试

```bash
kubectl logs <pod-name>                         # 查看日志
kubectl logs <pod-name> -c <container-name>     # 多容器日志查看
kubectl exec -it <pod-name> -- /bin/bash        # 进入容器终端
kubectl attach <pod-name>                       # 附着并监控前台任务
```

### 🎯 配置应用 & 部署

```bash
kubectl apply -f deployment.yaml                # 应用或更新资源
kubectl delete -f deployment.yaml               # 删除资源
kubectl rollout restart deployment <name>       # 热重启
kubectl rollout status deployment <name>        # 查看滚动更新状态
```

---

## 🧪 实战示例

### ✅ 1. 快速排查 Pod 异常状态

```bash
kubectl get pods -n myapp
kubectl describe pod myapp-xxxx-yyy -n myapp
kubectl logs myapp-xxxx-yyy -n myapp
```

> 常见状态如 CrashLoopBackOff、ErrImagePull 会在 describe 的 Events 部分显示错误原因。

---

### ✅ 2. 容器调试 & 网络连通测试

```bash
kubectl exec -it <pod-name> -- /bin/sh
# 在容器内执行：
curl http://<svc-name>:<port>
ping <pod-ip>
```

---

## 🧩 YAML 配置文件管理建议

- 所有资源定义使用 Git 管理
- 使用 `kubectl apply -f` 保持幂等配置
- 合理使用 `kubectl diff` 预览变更
- 将配置分层（如 dev/stage/prod）提升环境一致性

---

## 🚨 常见问题排查

| 问题场景            | 排查建议                                                   |
| ------------------- | ---------------------------------------------------------- |
| Pod 一直重启        | 查看 logs 与 Events，排查健康检查、端口、环境变量等        |
| 日志为空            | 容器是否已崩溃？尝试加 `--previous`                        |
| exec 失败           | 容器镜像是否包含 shell？默认 Alpine 无 bash                |
| 资源 apply 后未生效 | 是否被 MutatingWebhook 改写？检查 finalizers / controllers |

---

## 🧠 拓展技巧

- `kubectl top` 查看资源占用
- `kubectl port-forward` 实现本地访问集群服务
- 使用 `k9s` 等工具提升命令行效率
- 整合 `kubectx` / `kubens` 管理上下文和命名空间

---

> 📁 本文档建议作为 `K8s CLI 工具包` 模块收录，配合生产集群权限管控与操作规范持续维护。
