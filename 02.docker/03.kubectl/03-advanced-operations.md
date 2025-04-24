# 03 | 高级操作与调试技巧

本模块覆盖 `kubectl` 在多命名空间管理、Label 选择器、Context 管理、端口转发等高级操作技巧。

---

## 📦 命名空间管理

```bash
kubectl get ns
kubectl get pods -n kube-system
kubectl create ns test
```

## 🎯 标签选择器

```bash
kubectl get pods -l app=myapp
kubectl delete pods -l env=dev
```

## 🧭 上下文管理（多集群）

```bash
kubectl config get-contexts
kubectl config use-context staging-cluster
```

## 🌐 本地端口转发

```bash
kubectl port-forward svc/myapp 8080:80
```

> 本地访问 http://localhost:8080 等同于访问 Service
