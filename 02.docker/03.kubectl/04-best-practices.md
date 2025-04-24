# 04 | 最佳实践与常见问题排查

本模块整理 `kubectl` 使用中的典型问题、优化建议与命令技巧，助力提高日常运维效率与故障恢复速度。

---

## 💡 使用建议

- 使用 `alias k=kubectl` 简化命令输入
- 配合 `watch` 工具实现实时监控：`watch kubectl get pods`
- 使用 `kubectl explain` 了解字段结构

---

## 🚨 常见问题排查表

| 问题场景                | 原因与建议                                    |
| ----------------------- | --------------------------------------------- |
| 命令报错 context 不存在 | 使用 `kubectl config get-contexts` 查看并切换 |
| YAML 无法生效           | 使用 `kubectl apply -f` 结合 `kubectl diff`   |
| Pod 一直重启            | 查看日志 + Events，排查探针或环境变量         |
| 无法进入容器终端        | 镜像中缺少 sh/bash？                          |

---

## 🧠 提效工具推荐

- `kubectx/kubens`：多集群/命名空间管理
- `k9s`：终端可视化运维
- `stern`：多容器日志聚合工具
