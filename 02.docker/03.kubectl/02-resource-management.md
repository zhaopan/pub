# 02 | 资源管理与 YAML 应用

本模块介绍如何使用 `kubectl` 管理 Kubernetes 中的资源，包括创建、更新、扩缩容、滚动更新与回滚等操作。

---

## 📌 常用命令

```bash
kubectl apply -f xxx.yaml          # 创建或更新资源
kubectl delete -f xxx.yaml         # 删除资源
kubectl rollout restart deploy X   # 热更新 Deployment
kubectl rollout status deploy X    # 查看滚动更新状态
kubectl scale deploy X --replicas=3  # 扩缩容
kubectl patch                      # 补丁更新
```

---

## 🧪 实战

### ✅ 应用资源配置

```bash
kubectl apply -f deployment.yaml
kubectl get deploy,pods,svc -n myapp
```

### ✅ 扩容服务实例

```bash
kubectl scale deployment web --replicas=5
```

### ✅ 热更新镜像版本

```bash
kubectl set image deployment/web web=myapp:v2
kubectl rollout status deployment/web
```
