# kubectl remark

```bash
# 查看所有 pod 列表,  -n 后跟 namespace, 查看指定的命名空间
kubectl get nodes
kubectl get pod
kubectl get pods -n kube-system

# 查看 RC 和 service 列表， -o wide 查看详细信息
kubectl get rc,svc
kubectl get pod,svc -o wide
kubectl get pod <pod-name> -o yaml

# 查看 endpoint 列表
kubectl get endpoints
kubectl get namespace

# 显示 Node 的详细信息
kubectl describe node 192.168.0.212

# 显示 Pod 的详细信息, 特别是查看 pod 无法创建的时候的日志
kubectl describe pod <pod-name>
eg:
kubectl describe pod redis-master-tqds9

# 根据 yaml 创建资源, apply 可以重复执行，create 不行
kubectl create -f pod.yaml
kubectl apply -f pod.yaml

# 基于 pod.yaml 定义的名称删除 pod
kubectl delete -f pod.yaml

# 删除所有包含某个 label 的pod 和 service
kubectl delete pod,svc -l name=<label-name>

kubectl delete namespace xxx

# 删除所有 Pod
kubectl delete pod --all

# 执行 pod 的 date 命令
kubectl exec <pod-name> -- date
kubectl exec <pod-name> -- bash
eg:
kubectl exec spdweb-6b7c5dbc6-hkg9c -- ping 10.24.51.9

# 通过bash获得 pod 中某个容器的TTY，相当于登录容器
kubectl exec -it <pod-name> -c <container-name> -- bash
eg:
kubectl exec -it redis-master-cln81 -- bash

# 查看容器的日志
kubectl logs <pod-name>
kubectl logs -f <pod-name> # 实时查看日志

# 容器日志输出到文件
eg:
log_pod release-xxxx 10000 > xxxx.txt
```
