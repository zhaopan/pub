# 01 | kubectl 基础使用实践

本模块介绍 `kubectl` 最常用的基础命令，适用于资源查看、日志调试、进入容器终端等日常集群操作。

---

## 🎯 常用命令速查表

```bash
kubectl get pods                        # 查看当前命名空间的 Pod
kubectl get svc -A                     # 查看所有 Service（含命名空间）
kubectl describe pod <pod-name>        # 查看 Pod 的详细状态
kubectl logs <pod-name>                # 查看日志
kubectl exec -it <pod-name> -- sh      # 进入容器终端
```

---

## 🧪 实战示例

### ✅ 查看所有资源状态

```bash
kubectl get all -n myapp
```

### ✅ 查看指定 Deployment 所属 Pod 日志

```bash
kubectl get pods -l app=myapp -n myapp
kubectl logs myapp-xxxxx-yyy -n myapp
```

### ✅ 容器内 curl 访问另一个服务

```bash
kubectl exec -it myapp-pod -- curl http://my-svc:80
```

---

## 🚨 常见问题排查

| 问题          | 排查建议                                             |
| ------------- | ---------------------------------------------------- |
| 资源显示为空  | 是否正确切换命名空间？                               |
| 日志无输出    | 容器是否正常运行？尝试 `--previous` 查看历史容器日志 |
| exec 无法进入 | 镜像中是否含有 sh/bash？                             |
